//
//  ItemsNewController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsNewController.h"
#import "Spend.h"


@implementation ItemsNewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

# pragma mark LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Override the DetailViewController viewDidLoad with different navigation bar items and title.
    self.title = @"New Book";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																	  target:self 
																	  action:@selector(cancel:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
																	   target:self 
																	   action:@selector(save:)] autorelease];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)cancel:(id)sender {
	NSLog( @"[ItemsNewController cancel]" );
	
	// Delete the managed object.
	NSManagedObjectContext *context = [spend managedObjectContext];
	[context deleteObject:spend];
	
	NSError *error;
	if (![context save:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
	
	NSLog( @"[ItemsNewController cancel] : END" );
}

- (IBAction)save:(id)sender {
	NSLog( @"[ItemsNewController save]" );
	
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
	NSLog( @"[ItemsNewController save] : END" );
}


# pragma mark Memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
