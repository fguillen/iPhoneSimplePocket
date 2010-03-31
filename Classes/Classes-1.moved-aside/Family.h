//
//  Family.h
//  SimplePocket
//
//  Created by Fernando Guillen on 29/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Icon;

@interface Family :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Icon * icon;

@end



