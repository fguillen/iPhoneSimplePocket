//
//  Spend.h
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Spend :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDecimalNumber * price;

- (NSString *) sectionName;

@end



