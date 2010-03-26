//
//  ItemsIndexController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ItemsIndexController : UIViewController {
	UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction) addItem:(id)sender;

@end
