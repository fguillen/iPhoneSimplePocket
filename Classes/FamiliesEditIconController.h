//
//  FamiliesEditIconController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 30/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Family;

@interface FamiliesEditIconController : UITableViewController {
	Family *family;

}

@property (nonatomic,retain) Family *family;

- (IBAction)cancel;
- (IBAction)save;

@end
