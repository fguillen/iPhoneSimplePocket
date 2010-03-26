//
//  ItemsEditTitleController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsEditPriceController.h"
#import "Spend.h"


@implementation ItemsEditPriceController

@synthesize textField;
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


# pragma Life

- (void)viewDidLoad {
    [super viewDidLoad];
	
	textField.text = [spend.price descriptionWithLocale:nil];;
	textField.placeholder = [spend.price descriptionWithLocale:nil];;
	[textField becomeFirstResponder];
	
	// Configure the save and cancel buttons.
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark Save and cancel operations

- (IBAction)save {
	NSLog( @"[ItemsEditTitleController save]" );
	
	spend.price = [NSDecimalNumber decimalNumberWithString:textField.text]; 
	
	NSError *error = nil;
	if( ![[spend managedObjectContext] save:&error] ){
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[ItemsEditTitleController save] : END" );
}


- (IBAction)cancel {
	NSLog( @"[ItemsEditTitleController cancel]" );
    
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[ItemsEditTitleController cancel] : END" );
}




# pragma mark Memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)dealloc {
	[textField release];
	[spend release];
    [super dealloc];
}


@end
