//
//  FamiliesShowController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesShowController.h"
#import "FamiliesEditNameController.h"
#import "FamiliesEditIconController.h"
#import "SimplePocketAppDelegate.h"
#import "Family.h"
#import "Icon.h"


@implementation FamiliesShowController

@synthesize family;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */


# pragma mark LifeCycle

- (void)viewDidLoad {
	NSLog( @"[FamiliesShowController viewDidLoad]" );
    [super viewDidLoad];
	
	// Configure the title, title bar, and table view.
	self.title = @"Family Info";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.tableView.allowsSelectionDuringEditing = YES;
	NSLog( @"[FamiliesShowController viewDidLoad] : END" );
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

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




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog( @"[FamiliesShowController cellForRowAtIndexPath:%d]", indexPath.row );
    static NSString *CellIdentifierName = @"CellName";
    static NSString *CellIdentifierIcon = @"CellIcon";
    
	UITableViewCell *cell = nil;
    
	switch (indexPath.row) {
		case 0:
			NSLog( @"[FamiliesShowController cellForRowAtIndexPath] : Name" );
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierName];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifierName] autorelease];
				cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			cell.textLabel.text = @"Name";
			cell.detailTextLabel.text = family.name;
			break;

		case 1:
			NSLog( @"[FamiliesShowController cellForRowAtIndexPath] : Icon" );
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierIcon];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierIcon] autorelease];
				cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			if( family.icon ) {
				cell.textLabel.text = family.icon.filename;
				NSString *path = [[NSBundle mainBundle] pathForResource:family.icon.filename ofType:@"png"];
				UIImage *theImage = [UIImage imageWithContentsOfFile:path];
				cell.imageView.image = theImage;
			} else {
				cell.textLabel.text = @"no icon";
				NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"png"];
				UIImage *theImage = [UIImage imageWithContentsOfFile:path];
				cell.imageView.image = theImage;
			}
			break;
			
		default:
			break;
	}
	
    NSLog( @"[FamiliesShowController cellForRowAtIndexPath:%d] : END", indexPath.row );
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"[FamiliesShowController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	switch(indexPath.row) {
		case 0:
			NSLog( @"name" );
			FamiliesEditNameController *familiesEditNameController = [[FamiliesEditNameController alloc] initWithNibName:@"FamiliesEditNameView" bundle:nil];
			familiesEditNameController.family = [self family];			
			[[self navigationController] pushViewController:familiesEditNameController animated:YES];
			[familiesEditNameController release];
			break;
		case 1:
			NSLog( @"icon" );
			FamiliesEditIconController *familiesEditIconController = [[FamiliesEditIconController alloc] initWithStyle:UITableViewStyleGrouped];
			familiesEditIconController.family = [self family];			
			[[self navigationController] pushViewController:familiesEditIconController animated:YES];
			[familiesEditIconController release];
			break;
		default:
			break;
	}
	
	NSLog( @"[FamiliesShowController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

# pragma mark Memory Management



- (void)dealloc {
	[family release];
    [super dealloc];
}


@end

