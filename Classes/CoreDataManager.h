//
//  CoreDataManager.h
//  SimplePocket
//
//  Created by Fernando Guillen on 24/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CoreDataManager : NSObject {
	NSFetchedResultsController *iconsFetchedResultsController;
	NSFetchedResultsController *itemsFetchedResultsController;
	NSFetchedResultsController *familiesFetchedResultsController;
}

@property (nonatomic, retain) NSFetchedResultsController *iconsFetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *itemsFetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *familiesFetchedResultsController;

- (NSFetchedResultsController *)iconsFetchedResultsController;
- (NSFetchedResultsController *)itemsFetchedResultsController;
- (NSFetchedResultsController *)familiesFetchedResultsController;
- (void)feedItems;
- (void)feedIcons;

@end
