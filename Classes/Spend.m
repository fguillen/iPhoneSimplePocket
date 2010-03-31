// 
//  Spend.m
//  SimplePocket
//
//  Created by Fernando Guillen on 30/03/10.
//  Copyright 2010 FernandoGuillen.info. All rights reserved.
//

#import "Spend.h"

#import "Family.h"

@implementation Spend 

@dynamic name;
@dynamic date;
@dynamic price;
@dynamic families;

- (NSString *) sectionName{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	return [dateFormatter stringFromDate:self.date];
}

@end
