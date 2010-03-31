//
//  FamiliesShowController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Family;


@interface FamiliesShowController : UITableViewController {
	Family *family;
}

@property (nonatomic, retain) Family *family;

@end
