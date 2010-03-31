//
//  ItemsEditFamiliesController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 31/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "FamiliesIndexController.h"
@class Spend;

@interface ItemsEditFamiliesController : FamiliesIndexController {
	Spend *spend;
}

@property (nonatomic,retain) Spend *spend;

- (IBAction)cancel;
- (IBAction)save;

@end
