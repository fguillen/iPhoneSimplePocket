//
//  ItemsEditFamiliesController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 31/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsEditFamiliesController.h"
#import "SimplePocketAppDelegate.h"
#import "CoreDataManager.h"
#import "Spend.h"


@implementation ItemsEditFamiliesController

@synthesize spend;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
	NSLog( @"[ItemsEditFamiliesController viewDidLoad]" );
    [super viewDidLoad];
	
	// Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	NSLog( @"[ItemsEditFamiliesController viewDidLoad] : END" );
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark Table methods

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"ItemsEditFamiliesController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	Family *family = (Family *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	if( [spend.families containsObject:family] ){
		[spend removeFamiliesObject:family];
	} else {
		[spend addFamiliesObject:family];
	}
	
	[tableView reloadData];
	
	NSLog( @"ItemsEditFamiliesController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"ItemsEditFamiliesController accessoryTypeForRowWithIndexPath:%d]", indexPath.row );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] familiesFetchedResultsController];
	
	Family *family = (Family *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
	
	if( [spend.families containsObject:family] ){
		accessoryType = UITableViewCellAccessoryCheckmark;
	}
	
	NSLog( @"ItemsEditFamiliesController accessoryTypeForRowWithIndexPath:%d] : END", indexPath.row );
	return accessoryType;
}

#pragma mark Save and cancel operations

- (IBAction)save {
	NSLog( @"[ItemsEditFamiliesController save]" );
	
	NSError *error = nil;
	if( ![[spend managedObjectContext] save:&error] ){
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[ItemsEditFamiliesController save] : END" );
}


- (IBAction)cancel {
	NSLog( @"[ItemsEditFamiliesController cancel]" );
    
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[ItemsEditFamiliesController cancel] : END" );
}

#pragma mark memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
