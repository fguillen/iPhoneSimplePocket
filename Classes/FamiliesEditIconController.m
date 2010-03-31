//
//  FamiliesEditIconController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesEditIconController.h"
#import "SimplePocketAppDelegate.h"
#import "CoreDataManager.h"
#import "Family.h"
#import "Icon.h"


@implementation FamiliesEditIconController


@synthesize family;



- (void)viewDidLoad {
	NSLog( @"[FamiliesEditIconController viewDidLoad]" );
    [super viewDidLoad];
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	// Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	NSLog( @"[FamiliesEditIconController viewDidLoad] : END" );
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



#pragma mark Table view methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog( @"FamiliesEditIconController numberOfSectionsInTableView]" );
	NSInteger numCount = 1;
	NSLog( @"FamiliesEditIconController numberOfSectionsInTableView] : %d", numCount );
    return numCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[FamiliesEditIconController numberOfRowsInSection:%d]", section );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	NSInteger numCount = [sectionInfo numberOfObjects];
	NSLog( @"[FamiliesEditIconController numberOfRowsInSection:%d] : %d", section, numCount );
    return numCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog( @"[FamiliesEditIconController cellForRowAtIndexPath:%@]", indexPath );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Icon *icon = (Icon *)[fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = icon.filename;
    NSString *path = [[NSBundle mainBundle] pathForResource:icon.filename ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = theImage;
	
	NSLog( @"[FamiliesEditIconController cellForRowAtIndexPath:%@] : END", indexPath );
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"FamiliesEditIconController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	Icon *icon = (Icon *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	if( family.icon != icon ){
		family.icon = icon;
		[tableView reloadData];
	}
	
	NSLog( @"FamiliesEditIconController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSLog( @"FamiliesEditIconController didSelectRowAtIndexPath:%d]", indexPath.row );
//	
//    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
//	
//    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
//        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;	
//    } else {
//        thisCell.accessoryType = UITableViewCellAccessoryNone;
//    }
//	
//	NSLog( @"FamiliesEditIconController didSelectRowAtIndexPath:%d] : END", indexPath.row );
//}
//
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"FamiliesEditIconController accessoryTypeForRowWithIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	Icon *icon = (Icon *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
	
	if( family.icon == icon ){
		accessoryType = UITableViewCellAccessoryCheckmark;
	}
	
	NSLog( @"FamiliesEditIconController accessoryTypeForRowWithIndexPath:%d] : END", indexPath.row );
	return accessoryType;
}


#pragma mark Save and cancel operations

- (IBAction)save {
	NSLog( @"[FamiliesEditNameController save]" );
	
	NSError *error = nil;
	if( ![[family managedObjectContext] save:&error] ){
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[FamiliesEditNameController save] : END" );
}


- (IBAction)cancel {
	NSLog( @"[FamiliesEditNameController cancel]" );
	
	[[family managedObjectContext] refreshObject:family mergeChanges:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[FamiliesEditNameController cancel] : END" );
}



#pragma mark Memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[family release];
    [super dealloc];
}


@end

