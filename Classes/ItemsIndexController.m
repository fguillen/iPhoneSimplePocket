//
//  ItemsIndexController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsIndexController.h"
#import "ItemsShowController.h"
#import "ItemsNewController.h"
#import "SimplePocketAppDelegate.h"
#import "CoreDataManager.h"
#import "Spend.h"


@implementation ItemsIndexController

@synthesize tableView;


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	NSLog( @"[ItemsIndexController viewDidLoad]" );
    [super viewDidLoad];
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSLog( @"[ItemsIndexController viewDidLoad] : END" );
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self.tableView reloadData];
}



#pragma mark Table view methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog( @"ItemsIndexController numberOfSectionsInTableView]" );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
	NSInteger numCount = [[fetchedResultsController sections] count];
	NSLog( @"ItemsIndexController numberOfSectionsInTableView] : %d", numCount );
    return numCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[ItemsIndexController numberOfRowsInSection:%d]", section );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	NSInteger numCount = [sectionInfo numberOfObjects];
	NSLog( @"[ItemsIndexController numberOfRowsInSection:%d] : %d", section, numCount );
    return numCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog( @"[ItemsIndexController cellForRowAtIndexPath:%@]", indexPath );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Spend *spend = (Spend *)[fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = spend.name;
	cell.detailTextLabel.text = [spend.price descriptionWithLocale:nil];
	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"battery" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = theImage;
	
	NSLog( @"[ItemsIndexController cellForRowAtIndexPath:%@] : END", indexPath );
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"ItemsIndexController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
	ItemsShowController *itemsShowController = [[ItemsShowController alloc] initWithStyle:UITableViewStyleGrouped];
	Spend *selectedSpend = (Spend *)[fetchedResultsController objectAtIndexPath:indexPath];
	itemsShowController.spend = selectedSpend;
	
	[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController] pushViewController:itemsShowController animated:YES];
	
	[itemsShowController release];
	
	NSLog( @"ItemsIndexController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSLog( @"[ItemsIndexController titleForHeaderInSection:%d]", section );
	
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] itemsFetchedResultsController];
	
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	NSArray *spendsOnSection = [sectionInfo objects];
	
	NSDecimal total = [[NSNumber numberWithInt:0] decimalValue];
	Spend *spend = nil;
	for (spend in spendsOnSection) {
		NSDecimal price = [spend.price decimalValue];
		NSLog( @"[ItemsIndexController titleForHeaderInSection] : spend.name: %@", spend.name ); 
		NSLog( @"[ItemsIndexController titleForHeaderInSection] : spend.price: %@", spend.price ); 
		NSLog( @"[ItemsIndexController titleForHeaderInSection] : spend.price decimalValue: %d", [spend.price decimalValue]); 
		NSLog( @"[ItemsIndexController titleForHeaderInSection] : price: %1.2f", price ); 
		
		NSDecimalAdd( &total, &total, &price, NSRoundBankers);
		NSLog( @"[ItemsIndexController titleForHeaderInSection] : total: %d", total );
	}
	
	NSString *sectionName = [NSString stringWithFormat:@"%@ (%d)", sectionInfo.name, total];
	
	NSLog( @"[ItemsIndexController titleForHeaderInSection:%d] : %@ : END", section, sectionName );
	return sectionName;
}

# pragma mark Actions
- (IBAction) addItem:(id)sender{
	NSLog( @"[ItemsIndexController addItem]" );

	
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	Spend *selectedSpend = (Spend *)[NSEntityDescription insertNewObjectForEntityForName:@"Spend" inManagedObjectContext:context];
	
	ItemsNewController *itemsNewController = [[ItemsNewController alloc] initWithStyle:UITableViewStyleGrouped];
	itemsNewController.spend = selectedSpend;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsNewController];
    [self.navigationController presentModalViewController:navController animated:YES];
	
	[itemsNewController release];
	[navController release];
	
	NSLog( @"[ItemsIndexController addItem] : END" );
}


#pragma mark Memory

- (void)dealloc {
	[tableView release];
    [super dealloc];
}


@end

