//
//  ItemsNavigationController.h
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ItemsNavigationController : UIViewController {
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
