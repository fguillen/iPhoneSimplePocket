//
//  Icon.h
//  SimplePocket
//
//  Created by Fernando Guillen on 30/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Family;

@interface Icon :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSSet* families;

@end


@interface Icon (CoreDataGeneratedAccessors)
- (void)addFamiliesObject:(Family *)value;
- (void)removeFamiliesObject:(Family *)value;
- (void)addFamilies:(NSSet *)value;
- (void)removeFamilies:(NSSet *)value;

@end

