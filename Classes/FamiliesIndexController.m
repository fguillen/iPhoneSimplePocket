//
//  FamiliesIndexController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesIndexController.h"
#import "FamiliesShowController.h"
#import "FamiliesNewController.h"
#import "SimplePocketAppDelegate.h"
#import "CoreDataManager.h"
#import "Family.h"
#import "Icon.h"


@implementation FamiliesIndexController

@synthesize tableView;


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	NSLog( @"[FamiliesIndexController viewDidLoad]" );
    [super viewDidLoad];
	
	NSFetchedResultsController *fetchedResultsController = 
	[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;

	
	NSLog( @"[FamiliesIndexController viewDidLoad] : END" );
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
	NSLog( @"FamiliesIndexController numberOfSectionsInTableView]" );
	
	NSFetchedResultsController *fetchedResultsController = 
	[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	NSInteger numCount = [[fetchedResultsController sections] count];
	NSLog( @"FamiliesIndexController numberOfSectionsInTableView] : %d", numCount );
    return numCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[FamiliesIndexController numberOfRowsInSection:%d]", section );
	
	NSFetchedResultsController *fetchedResultsController = 
	[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	NSInteger numCount = [sectionInfo numberOfObjects];
	NSLog( @"[FamiliesIndexController numberOfRowsInSection:%d] : %d", section, numCount );
    return numCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog( @"[FamiliesIndexController cellForRowAtIndexPath:%@]", indexPath );
	
	NSFetchedResultsController *fetchedResultsController = 
	[	[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Family *family = (Family *)[fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = family.name;
	
	// image
	NSString *filename = @"default";
	if( family.icon ){
		filename = family.icon.filename;
	}
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = theImage;
	
//	cell.showsReorderControl = YES;
//	cell.editing = YES;
	
	NSLog( @"[FamiliesIndexController cellForRowAtIndexPath:%@] : END", indexPath );
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"FamiliesIndexController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	Family *selectedFamily = (Family *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	FamiliesShowController *familiesShowController = [[FamiliesShowController alloc] initWithStyle:UITableViewStyleGrouped];
	familiesShowController.family = selectedFamily;
	
	[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController] pushViewController:familiesShowController animated:YES];
	
	[familiesShowController release];
	
	NSLog( @"FamiliesIndexController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}




- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog( @"[FamiliesIndexController moveRowAtIndexPath:%d toIndexPath:%d]", fromIndexPath.row, toIndexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];

	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	
	Family *selectedFamily = (Family *)[fetchedResultsController objectAtIndexPath:fromIndexPath];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
	NSMutableArray *objects = [NSMutableArray arrayWithArray:[sectionInfo objects]];
	
	[objects removeObjectAtIndex:fromIndexPath.row];
	[objects insertObject:selectedFamily atIndex:toIndexPath.row];
	
	for (int i = 0; i < [objects count]; i++) {
		Family *actualFamily = [objects objectAtIndex:i];
		actualFamily.order = [NSNumber numberWithInt:i];
		NSLog( @"[[FamiliesIndexController moveRowAtIndexPath] : family:%@ toOrder:%d", actualFamily.name, i );
	}

	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	
	NSLog( @"[FamiliesIndexController moveRowAtIndexPath:%d toIndexPath:%d] : END", fromIndexPath.row, toIndexPath.row );
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	NSLog( @"[FamiliesIndexController setEditing:%d]", editing );
    [super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
	NSLog( @"[FamiliesIndexController setEditing:%d] : END", editing );
}

- (void)tableView:(UITableView *)_tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog( @"[FamiliesIndexController commitEditingStyle:%d forRowAtIndexPath:%d]", editingStyle, indexPath.row );
	
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSFetchedResultsController *fetchedResultsController = 
			[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];		
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);
		}
		
		if (![fetchedResultsController performFetch:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		
		[tableView reloadData];
    }
	

	
	NSLog( @"[FamiliesIndexController commitEditingStyle:%d forRowAtIndexPath:%d] : END", editingStyle, indexPath.row );
}

# pragma mark Actions
- (IBAction) addFamily:(id)sender{
	NSLog( @"[FamiliesIndexController addFamily]" );
	
	FamiliesNewController *familiesNewController = [[FamiliesNewController alloc] initWithNibName:@"FamiliesNewView" bundle:nil];
	familiesNewController.indexController = self;
    [self.navigationController presentModalViewController:familiesNewController animated:YES];
	
	[familiesNewController release];
	
	NSLog( @"[FamiliesIndexController addFamily] : END" );
}

- (void) reloadData {
	NSLog( @"[FamiliesIndexController reloadData]" );
	[tableView reloadData];
	NSLog( @"[FamiliesIndexController reloadData] : END" );
}

#pragma mark Memory

- (void)dealloc {
	[tableView release];
    [super dealloc];
}


@end

