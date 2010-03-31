//
//  FamiliesNewController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

//#import "FamiliesShowController.h"

@class Family;
@class FamiliesIndexController;

@interface FamiliesNewController : UIViewController {
	UITextField *nameTextField;
	FamiliesIndexController *indexController;
	Family *family;
}

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) Family *family;
@property (nonatomic, retain) FamiliesIndexController *indexController;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
