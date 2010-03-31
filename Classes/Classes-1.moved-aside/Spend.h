//
//  Spend.h
//  SimplePocket
//
//  Created by Fernando Guillen on 29/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Family;

@interface Spend :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSSet* families;

@end


@interface Spend (CoreDataGeneratedAccessors)
- (void)addFamiliesObject:(Family *)value;
- (void)removeFamiliesObject:(Family *)value;
- (void)addFamilies:(NSSet *)value;
- (void)removeFamilies:(NSSet *)value;

- (NSString *) sectionName;

@end






