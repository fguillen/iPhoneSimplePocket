//
//  FamiliesEditNameController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesEditNameController.h"
#import "Family.h"


@implementation FamiliesEditNameController

@synthesize textField;
@synthesize family;

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
	
	textField.text = family.name;
	textField.placeholder = family.name;
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
	NSLog( @"[FamiliesEditNameController save]" );
	
	family.name = textField.text;
	
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
    
    [self.navigationController popViewControllerAnimated:YES];
	
	NSLog( @"[FamiliesEditNameController cancel] : END" );
}




# pragma mark Memory

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)dealloc {
	[textField release];
	[family release];
    [super dealloc];
}


@end
