//
//  FamiliesIndexController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 30/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FamiliesIndexController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
	UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (IBAction) addFamily:(id)sender;
- (void) reloadData;

@end
