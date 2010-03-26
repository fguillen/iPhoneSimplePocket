//
//  ItemsEditTitleController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Spend;

@interface ItemsEditTitleController : UIViewController {
	UITextField *textField;
	Spend *spend;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) Spend *spend;

- (IBAction)cancel;
- (IBAction)save;

@end
