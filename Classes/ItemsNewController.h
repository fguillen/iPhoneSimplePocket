//
//  ItemsNewController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "ItemsShowController.h"

@class Spend;


@interface ItemsNewController : UIViewController {
	UITextField *nameTextField;
	UITextField *priceTextField;
	UIDatePicker *datePicker;
	Spend *spend;
}

@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet UITextField *priceTextField;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) Spend *spend;

- (IBAction)nameDone:(id)sender;
- (IBAction)priceDone:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
