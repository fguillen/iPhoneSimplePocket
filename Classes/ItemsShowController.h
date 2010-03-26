//
//  ItemsShowController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Spend;


@interface ItemsShowController : UITableViewController {
	Spend *spend;
}

@property (nonatomic, retain) Spend *spend;

@end
