//
//  Icons.m
//  SimplePocket
//
//  Created by Fernando Guillen on 23/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "IconsController.h"
#import "SimplePocketAppDelegate.h"
#import "CoreDataManager.h"


@implementation IconsController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	[self performFetch];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog( @"IconsController numberOfSectionsInTableView]" );
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	NSInteger numCount = [[fetchedResultsController sections] count];
	NSLog( @"IconsController numberOfSectionsInTableView] : %d", numCount );
    return numCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[IconsController numberOfRowsInSection:%d]", section );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	NSInteger numCount = [sectionInfo numberOfObjects];
	NSLog( @"[IconsController numberOfRowsInSection:%d] : %d", section, numCount );
    return numCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog( @"[IconsController cellForRowAtIndexPath:%@]", indexPath );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [managedObject valueForKey:@"filename"];
	
	NSLog( @"[IconsController cellForRowAtIndexPath:%@] : END", indexPath );
    return cell;
}










#pragma mark -
#pragma mark Fetched results controller


- (void)performFetch {
	NSLog( @"[IconsController performFetch]" );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	NSLog( @"[IconsController performFetch] : END" );
}

   




# pragma mark Initialization
- (void)initializeIconsList {
	NSLog( @"[IconsController initializeIconsList]" );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];

	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	
	// delete all icons
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
	for (NSManagedObject *icon in [sectionInfo objects]) {
		[context deleteObject:icon];
	}
	
	
	
	// create default icon list
	NSArray *iconFilenames = [NSArray arrayWithObjects: @"arrow.png", @"battery.png", @"batteryFull.png", nil];	
	for (NSString *iconFilename in iconFilenames) {
		NSManagedObject *icon = [NSEntityDescription insertNewObjectForEntityForName:@"Icon" inManagedObjectContext:context];
		[icon setValue:iconFilename forKey:@"filename"];
	}
	
	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSLog( @"[IconsController initializeIconsList] : END" );
}	

#pragma mark Memory

- (void)dealloc {
    [super dealloc];
}


@end

