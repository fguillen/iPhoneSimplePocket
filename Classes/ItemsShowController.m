//
//  ItemsShowController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsShowController.h"
#import "ItemsEditTitleController.h"
#import "ItemsEditPriceController.h"
#import "ItemsEditDateController.h"
#import "ItemsEditFamiliesController.h"
#import "SimplePocketAppDelegate.h"
#import "Spend.h"
#import "Family.h"
#import "Icon.h"


@implementation ItemsShowController

@synthesize spend;

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
	NSLog( @"[ItemsShowController viewDidLoad]" );
    [super viewDidLoad];

	// Configure the title, title bar, and table view.
	self.title = @"Spend Info";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.tableView.allowsSelectionDuringEditing = YES;
	NSLog( @"[ItemsShowController viewDidLoad] : END" );
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
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog( @"[ItemsShowController numberOfRowsInSection:%d]", section );
	NSInteger count = 0;
	
	switch (section) {
		case 0:
			count = 3;
			break;
		default:
			count = spend.families.count;
			
			if( count == 0 ) {
				count = 1;
			}
			
			break;
	}
	NSLog( @"[ItemsShowController numberOfRowsInSection:%d]", section );
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifierDetails = @"CellDetails";
    static NSString *CellIdentifierFamilies = @"CellFamilies";
    
	UITableViewCell *cell = nil;
	
	if( indexPath.section == 0 ){
		 cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierDetails];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifierDetails] autorelease];
			cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
    
		switch (indexPath.row) {
			case 0:
				cell.textLabel.text = @"Name";
				cell.detailTextLabel.text = spend.name;
				break;
			case 1:
				cell.textLabel.text = @"Price";
				
				NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
				[numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
				NSString *priceFormatted = [numberFormatter stringFromNumber:spend.price];
				
				cell.detailTextLabel.text = priceFormatted;
				break;
			case 2:
				cell.textLabel.text = @"Date";
				cell.detailTextLabel.text = [spend.date description];
				break;
				
			default:
				break;
		}
	
	} else {
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierFamilies];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierFamilies] autorelease];
		}
		
		NSString *filename = @"default";
		
		if( spend.families.count > 0 ){
			Family *family = (Family *)[[spend.families allObjects] objectAtIndex:indexPath.row];
			filename = family.icon.filename;
		}

		cell.textLabel.text = filename;
		
		NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
		UIImage *theImage = [UIImage imageWithContentsOfFile:path];
		cell.imageView.image = theImage;
	}		
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"[ItemsShowController didSelectRowAtIndexPath:%d]", indexPath.row );
	
	if( indexPath.section == 0 ) {
		switch(indexPath.row) {
			case 0:
				NSLog( @"title" );
				ItemsEditTitleController *itemsEditTitleController = [[ItemsEditTitleController alloc] initWithNibName:@"ItemsEditTitleView" bundle:nil];
				itemsEditTitleController.spend = [self spend];			
				[[self navigationController] pushViewController:itemsEditTitleController animated:YES];
				[itemsEditTitleController release];
				break;
			case 1:
				NSLog( @"price" );
				ItemsEditPriceController *itemsEditPriceController = [[ItemsEditPriceController alloc] initWithNibName:@"ItemsEditPriceView" bundle:nil];
				itemsEditPriceController.spend = [self spend];			
				[[self navigationController] pushViewController:itemsEditPriceController animated:YES];
				[itemsEditPriceController release];
				break;
			case 2:
				NSLog( @"date" );
				ItemsEditDateController *itemsEditDateController = [[ItemsEditDateController alloc] initWithNibName:@"ItemsEditDateView" bundle:nil];
				itemsEditDateController.spend = [self spend];			
				[[self navigationController] pushViewController:itemsEditDateController animated:YES];
				[itemsEditDateController release];
				break;
			default:
				break;
		}
	} else {
		ItemsEditFamiliesController *itemsEditFamiliesController = [[ItemsEditFamiliesController alloc] initWithNibName:@"FamiliesIndexView" bundle:nil];
		itemsEditFamiliesController.spend = spend;
		[[self navigationController] pushViewController:itemsEditFamiliesController animated:YES];
		[itemsEditFamiliesController release];
	}
	NSLog( @"[ItemsShowController didSelectRowAtIndexPath:%d] : END", indexPath.row );
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleNone;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	NSLog( @"[ItemsShowController titleForHeaderInSection:%d]", section );
	NSString *title = @"Details";
	
	if( section == 1 ) {
		title = @"Families";
	}
	
	NSLog( @"[ItemsShowController titleForHeaderInSection:%d] : END : %@", section, title );
	return title;
}

# pragma mark Memory Management



- (void)dealloc {
	[spend release];
    [super dealloc];
}


@end

