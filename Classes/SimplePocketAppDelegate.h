//
//  SimplePocketAppDelegate.h
//  SimplePocket
//
//  Created by Fernando Guillen on 03/03/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

@class IconsController;
@class ItemsIndexController;
@class CoreDataManager;

@interface SimplePocketAppDelegate : NSObject <UIApplicationDelegate> {
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;	
	IconsController *iconsController;
	ItemsIndexController *itemsIndexController;
	CoreDataManager *cdm;
	
	UINavigationController *navigationController;
	
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) CoreDataManager *cdm;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) IconsController *iconsController;
@property (nonatomic, retain) ItemsIndexController *itemsIndexController;
//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSString *)applicationDocumentsDirectory;

@end

