//
//  SimplePocketAppDelegate.m
//  SimplePocket
//
//  Created by Fernando Guillen on 03/03/10.
//  Copyright FernandoGuillen.info 2010. All rights reserved.
//

#import "SimplePocketAppDelegate.h"
#import "IconsController.h"
#import "ItemsIndexController.h"
#import "CoreDataManager.h"
#import "RootViewController.h"


@implementation SimplePocketAppDelegate

@synthesize window;
@synthesize iconsController;
@synthesize itemsIndexController;
@synthesize cdm;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application { 
	
	// Initialize CoreDataManager
	cdm = [CoreDataManager alloc];

	[cdm feedIcons];
	
//	iconsController = [IconsController alloc];
//	[iconsController performFetch];
//	[iconsController initializeIconsList]; 
//	
//	
//	itemsIndexController = [[ItemsIndexController alloc] initWithNibName:@"ItemsIndexView" bundle:nil];
	
//	RootViewController *rootViewController = (RootViewController *)[navigationController topViewController];
//	rootViewController.managedObjectContext = self.managedObjectContext;
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

#pragma mark Initialize App



#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	NSLog( @"[SimplePocketAppDelegate managedObjectContext]" );
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
	
	NSLog( @"[SimplePocketAppDelegate managedObjectContext] : END" );
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	NSLog( @"[SimplePocketAppDelegate managedObjectModel]" );
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
	
	NSLog( @"[SimplePocketAppDelegate managedObjectModel] : END" );
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	NSLog( @"[SimplePocketAppDelegate persistentStoreCoordinator]" );
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"SimplePocket.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
	NSLog( @"[SimplePocketAppDelegate persistentStoreCoordinator] : END" );
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
	[iconsController release];
	[itemsIndexController release];
	
	[cdm release];
	[window release];
	[super dealloc];
}


@end

