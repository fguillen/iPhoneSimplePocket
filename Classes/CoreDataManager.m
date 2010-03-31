//
//  CoreDataManager.m
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "CoreDataManager.h"
#import "SimplePocketAppDelegate.h"
#import "Spend.h";


@implementation CoreDataManager

@synthesize iconsFetchedResultsController;
@synthesize itemsFetchedResultsController;
@synthesize familiesFetchedResultsController;

- (NSFetchedResultsController *)iconsFetchedResultsController {
	NSLog( @"[CoreDataManager iconsFetchedResultsController]" );
    
    if (iconsFetchedResultsController != nil) {
        return iconsFetchedResultsController;
    }
    
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Icon" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filename" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
	// aFetchedResultsController.delegate = self;
	
	self.iconsFetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	
	NSLog( @"[CoreDataManager iconsFetchedResultsController] : END" );
	return iconsFetchedResultsController;
}  


- (NSFetchedResultsController *)itemsFetchedResultsController {
	NSLog( @"[CoreDataManager itemsFetchedResultsController]" );
    
    if (itemsFetchedResultsController != nil) {
		NSLog( @"[CoreDataManager itemsFetchedResultsController] : END , with cached" );
        return itemsFetchedResultsController;
    }
    
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Spend" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:@"sectionName" cacheName:@"Root"];
	// aFetchedResultsController.delegate = self;
	
	self.itemsFetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	
	NSLog( @"[CoreDataManager itemsFetchedResultsController] : END" );
	return itemsFetchedResultsController;
}  

- (NSFetchedResultsController *)familiesFetchedResultsController {
	NSLog( @"[CoreDataManager familiesFetchedResultsController]" );
    
    if (familiesFetchedResultsController != nil) {
		NSLog( @"[CoreDataManager familiesFetchedResultsController] : END , with cached" );
        return familiesFetchedResultsController;
    }
    
	NSManagedObjectContext *context = [(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Family" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
	// aFetchedResultsController.delegate = self;
	
	self.familiesFetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	
	NSLog( @"[CoreDataManager familiesFetchedResultsController] : END" );
	return familiesFetchedResultsController;
} 


#pragma Feeding DataBase

- (void)feedItems {
	NSLog( @"[CoreDataManager feedItems]" );
	
	NSFetchedResultsController *fetchedResultsController = [self itemsFetchedResultsController];	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	// delete all items
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
	for (Spend *item in [sectionInfo objects]) {
		[context deleteObject:item];
	}
	
	
	for (int i = 0; i < 30; i++) {
		Spend *item = (Spend *)[NSEntityDescription insertNewObjectForEntityForName:@"Spend" inManagedObjectContext:context];
		item.name = [NSString stringWithFormat: @"name_%d", i];
		item.price = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:i] decimalValue]];
		item.date = [NSDate date];
	}
	
	// Save the context.
//	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSLog( @"[CoreDataManager feedItems] : END" );
}	


- (void)feedIcons {
	NSLog( @"[CoreDataManager feedIcons]" );
	
	NSFetchedResultsController *fetchedResultsController = 
		[[(SimplePocketAppDelegate *)[[UIApplication sharedApplication] delegate] cdm] iconsFetchedResultsController];
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	
	
	NSError *error = nil;
	if (![fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	// delete all icons
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:0];
	for (NSManagedObject *icon in [sectionInfo objects]) {
		[context deleteObject:icon];
	}
	
	
	
	// create default icon list
	NSArray *iconFilenames = [NSArray arrayWithObjects: @"default", @"arrow", @"battery", @"batteryFull", nil];	
	for (NSString *iconFilename in iconFilenames) {
		NSManagedObject *icon = [NSEntityDescription insertNewObjectForEntityForName:@"Icon" inManagedObjectContext:context];
		[icon setValue:iconFilename forKey:@"filename"];
	}
	
	// Save the context.
//	NSError *error = nil;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	NSLog( @"[CoreDataManager feedIcons] : END" );
}


@end
