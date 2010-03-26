// 
//  Spend.m
//  SimplePocket
//
//  Created by Fernando Guillen on 26/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "Spend.h"


@implementation Spend 

@dynamic name;
@dynamic date;
@dynamic price;

- (NSString *) sectionName{
	return [self.date description];
}

@end
