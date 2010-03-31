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
#import "Family.h"
#import "Icon.h"


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
	
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
	NSString *priceFormatted = [numberFormatter stringFromNumber:spend.price];
	
	cell.detailTextLabel.text = priceFormatted;
	
	// image
	NSString *filename = @"default";
	if( spend.families.count > 0 ){
		filename = [[(Family *)[[spend.families allObjects] objectAtIndex:0] icon] filename];
	}
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
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
		NSDecimalAdd( &total, &total, &price, NSRoundBankers);
	}

	
	NSDecimalNumber *total_number = [NSDecimalNumber decimalNumberWithDecimal:total];
	
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *total_formatted = [numberFormatter stringFromNumber:total_number];
	
	NSString *sectionName = [NSString stringWithFormat:@"%@ (%@)", sectionInfo.name, total_formatted];
	
	NSLog( @"[ItemsIndexController titleForHeaderInSection:%d] : %@ : END", section, sectionName );
	return sectionName;
}

# pragma mark Actions
- (IBAction) addItem:(id)sender{
	NSLog( @"[ItemsIndexController addItem]" );

	ItemsNewController *itemsNewController = [[ItemsNewController alloc] initWithNibName:@"ItemsNewView" bundle:nil];
    [self.navigationController presentModalViewController:itemsNewController animated:YES];
	
	[itemsNewController release];
	
	NSLog( @"[ItemsIndexController addItem] : END" );
}


#pragma mark Memory

- (void)dealloc {
	[tableView release];
    [super dealloc];
}


@end

