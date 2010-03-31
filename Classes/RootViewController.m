//
//  RootViewController.m
//  SimplePocket
//
//  Created by Fernando Guillen on 03/03/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ItemsIndexController.h"
#import "FamiliesIndexController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	NSLog( @"[RootViewController viewDidLoad]" );
    [super viewDidLoad];
	
	self.title = @"Menu";
	NSLog( @"[RootViewController viewDidLoad] : END" );
}

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}



#pragma mark -
#pragma mark Add a new object




#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"[RootViewController cellForRowAtIndexPath:%d]", [indexPath row] );
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch ([indexPath row]) {
		case 0:
			cell.textLabel.text = @"Items";
			break;
		case 1:
			cell.textLabel.text = @"Families";
			break;
		case 2:
			cell.textLabel.text = @"Informs";
			break;
		case 3:
			cell.textLabel.text = @"Send CVS";
			break;
		default:
			break;
	}
	
	
	NSLog( @"[RootViewController cellForRowAtIndexPath:%d] : END", [indexPath row] );
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog( @"[RootViewController didSelectRowAtIndexPath:%d]", [indexPath row] );
	
	switch ([indexPath row]) {
		case 0:
			[self showItems];
			break;
		case 1:
			[self showFamilies];
			break;
		default:
			break;
	}
	
	NSLog( @"[RootViewController didSelectRowAtIndexPath:%d] : END", [indexPath row] );
}

# pragma mark Menu Actions

- (void) showItems{
	NSLog( @"[RootViewController showItems]" );
	
	ItemsIndexController *itemsIndexController = [[ItemsIndexController alloc] initWithNibName:@"ItemsIndexView" bundle:nil];
	[[self navigationController] pushViewController:itemsIndexController animated:YES];
	[itemsIndexController release];
	
	NSLog( @"[RootViewController showItems] : END" );
}

- (void) showFamilies{
	NSLog( @"[RootViewController showFamilies]" );
	
	FamiliesIndexController *familiesIndexController = [[FamiliesIndexController alloc] initWithNibName:@"FamiliesIndexView" bundle:nil];
	[[self navigationController] pushViewController:familiesIndexController animated:YES];
	[familiesIndexController release];
	
	NSLog( @"[RootViewController showFamilies] : END" );
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [super dealloc];
}




@end

