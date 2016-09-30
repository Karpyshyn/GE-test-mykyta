//
//  ResultItem.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "ResultItem.h"

@implementation ResultItem
- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:_price forKey:@"price"];
	[aCoder encodeObject:_id forKey:@"id"];
	[aCoder encodeObject:_logo forKey:@"logo"];
	[aCoder encodeObject:_arrivalTime forKey:@"arrivalTime"];
	[aCoder encodeObject:_departureTime forKey:@"departureTime"];
	[aCoder encodeObject:_numberOfChanges forKey:@"numberOfChanges"];
	[aCoder encodeObject:_durationString forKey:@"durationString"];
	[aCoder encodeObject: [NSNumber numberWithInt:_durationInMinutes] forKey:@"durationInMinutes"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super init];
	_price = [aDecoder decodeObjectForKey:@"price"];
	_id = [aDecoder decodeObjectForKey:@"id"];
	_logo = [aDecoder decodeObjectForKey:@"logo"];
	_arrivalTime = [aDecoder decodeObjectForKey:@"arrivalTime"];
	_departureTime = [aDecoder decodeObjectForKey:@"departureTime"];
	_numberOfChanges = [aDecoder decodeObjectForKey:@"numberOfChanges"];
	_durationString = [aDecoder decodeObjectForKey:@"durationString"];
	_durationInMinutes = [[aDecoder decodeObjectForKey:@"durationInMinutes"] integerValue];
	return  self;
}

- (NSComparisonResult)compareByDeparture:(ResultItem *)other{
	return [self.departureTime compare:other.departureTime];
}

- (NSComparisonResult)compareByArrival:(ResultItem *)other{
	return [self.arrivalTime compare:other.arrivalTime];
}

- (NSComparisonResult)compareByDuration:(ResultItem *)other{
		return [[NSNumber numberWithInt:self.durationInMinutes] compare:[NSNumber numberWithInt:other.durationInMinutes]];
}

@end
