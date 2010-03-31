//
//  Family.h
//  SimplePocket
//
//  Created by Fernando Guillen on 30/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Spend;
@class Icon;

@interface Family :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* spends;
@property (nonatomic, retain) Icon * icon;

@end


@interface Family (CoreDataGeneratedAccessors)
- (void)addSpendsObject:(Spend *)value;
- (void)removeSpendsObject:(Spend *)value;
- (void)addSpends:(NSSet *)value;
- (void)removeSpends:(NSSet *)value;

@end

