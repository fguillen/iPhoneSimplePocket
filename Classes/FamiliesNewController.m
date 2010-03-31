//
//  FamiliesNewController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesNewController.h"
#import "SimplePocketAppDelegate.h"
#import "Family.h"
#import "FamiliesIndexController.h"


@implementation FamiliesNewController

@synthesize family;
@synthesize nameTextField;
@synthesize indexController;

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
    self.title = @"New Family";
	
	// Create new Family
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	family = (Family *)[NSEntityDescription insertNewObjectForEntityForName:@"Family" inManagedObjectContext:context];
	
	// start writting name
	[nameTextField becomeFirstResponder];
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
#pragma mark Actions

- (IBAction)cancel:(id)sender {
	NSLog( @"[FamiliesNewController cancel]" );
	
	// Delete the managed object.
	NSManagedObjectContext *context = [family managedObjectContext];
	[context deleteObject:family];
	
	NSError *error;
	if (![context save:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
	
	NSLog( @"[FamiliesNewController cancel] : END" );
}

- (IBAction)save:(id)sender {
	NSLog( @"[FamiliesNewController save]" );
	
	self.family.name = nameTextField.text;
	
	// Save the managed object.
	NSError *error;
	if (![[family managedObjectContext] save:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	
	[indexController reloadData];
	
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
	NSLog( @"[FamiliesNewController save] : END" );
}



# pragma mark Memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[indexController release];
    [super dealloc];
}


@end
