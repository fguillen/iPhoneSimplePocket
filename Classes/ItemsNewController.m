//
//  ItemsNewController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsNewController.h"
#import "SimplePocketAppDelegate.h"
#import "Spend.h"


@implementation ItemsNewController

@synthesize spend;
@synthesize nameTextField;
@synthesize priceTextField;
@synthesize datePicker;

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
    self.title = @"New Spend";

	// Create new Spend
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	spend = (Spend *)[NSEntityDescription insertNewObjectForEntityForName:@"Spend" inManagedObjectContext:context];

	// initialize datePicker
	datePicker.date = [NSDate date];
	
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
	
	self.spend.name = nameTextField.text;
	self.spend.price = [NSDecimalNumber decimalNumberWithString:priceTextField.text];
	self.spend.date = datePicker.date;
	
	// Save the managed object.
	NSError *error;
	if (![[spend managedObjectContext] save:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
	
	// Dismiss the modal view to return to the main list
    [self dismissModalViewControllerAnimated:YES];
	NSLog( @"[ItemsNewController save] : END" );
}

-(IBAction) nameDone:(id)sender{
	NSLog( @"[ItemsNewController nameDone]" );
	[nameTextField resignFirstResponder];
	[priceTextField becomeFirstResponder];
	NSLog( @"[ItemsNewController nameDone] : END" );
}

-(IBAction) priceDone:(id)sender{
	NSLog( @"[ItemsNewController priceDone]" );
	[priceTextField resignFirstResponder];
	[datePicker becomeFirstResponder];
	NSLog( @"[ItemsNewController priceDone] : END" );
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
