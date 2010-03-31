//
//  FamiliesEditNameController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Family;

@interface FamiliesEditNameController : UIViewController {
	UITextField *textField;
	Family *family;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) Family *family;

- (IBAction)cancel;
- (IBAction)save;

@end
