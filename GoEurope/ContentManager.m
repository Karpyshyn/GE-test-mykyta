//
//  ContentManager.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "ContentManager.h"
#import "NetworkManager.h"
#import "PersistantStorage.h"


@interface ContentManager()
@property(nonatomic,strong) NetworkManager * networkManager;
@property(nonatomic,strong) PersistantStorage * persistantStorage;
@property(nonatomic,strong) NSArray * urlSources;
@end

@implementation ContentManager

+ (instancetype)sharedContentManager{
	static dispatch_once_t onceToken = 0;
	static ContentManager *sharedManager = nil;
	dispatch_once(&onceToken,^{
		sharedManager = [ContentManager new];
	});
	return sharedManager;
}

- (instancetype)init{
	if(!self){
		self = [super init];
	}
	_urlSources = @[
					@"https://api.myjson.com/bins/3zmcy",
					@"https://api.myjson.com/bins/37yzm",
					@"https://api.myjson.com/bins/w60i"
					];
	_networkManager = [NetworkManager new];
	_persistantStorage = [PersistantStorage new];
	return self;
}

- (void)fetchResultsForTransportType:(ContentTypeTransportType)type order:(ContentOrderType)order withBlock:(void (^)(NSArray<ResultItem*> * arr))block failureBlock:(void (^)(NSError *error))failBlock{
	
	[_networkManager getByUrl:_urlSources[type] successBlock:^(id responseObject) {
		NSMutableArray * results = [NSMutableArray new];
		for(NSDictionary * item in responseObject){
			ResultItem * result = [ResultItem new];
			result.id = item[@"id"];
			result.logo = [item[@"provider_logo"] stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
			
			result.departureTime = item[@"departure_time"];
			result.arrivalTime = item[@"arrival_time"];
			
			NSArray * arrivalTimeComponents = [result.arrivalTime componentsSeparatedByString:@":"];
			NSInteger arrivalAbsoluteMinutes = [arrivalTimeComponents.firstObject intValue] * 60 + [arrivalTimeComponents.lastObject intValue];
			
			NSArray * departureTimeComponents = [result.departureTime componentsSeparatedByString:@":"];
			NSInteger departureAbsoluteMinutes = [departureTimeComponents.firstObject intValue] * 60 + [departureTimeComponents.lastObject intValue];
			
			NSInteger durationInMinutes = arrivalAbsoluteMinutes > departureAbsoluteMinutes ? arrivalAbsoluteMinutes - departureAbsoluteMinutes : arrivalAbsoluteMinutes + (24 * 60 - departureAbsoluteMinutes);
			
			result.durationInMinutes = durationInMinutes;
			
			NSInteger durationHours = (int)(durationInMinutes / 60);
			NSInteger durationMinutes = durationInMinutes % 60;
			
			result.durationString = [NSString stringWithFormat:@"%ld:%ldh",(long)durationHours, (long)durationMinutes];
			result.numberOfChanges = item[@"number_of_stops"];
			result.price = [NSString stringWithFormat:@"%.2f",[item[@"price_in_euros"] doubleValue]];
			[results addObject:result];
		}
		[_persistantStorage saveResults:results forUrl:_urlSources[type]];
		block([self orderData:results byType:order]);
		
	} failureBlock:^(NSError *error) {
		NSArray * resultsFromCache = [_persistantStorage getResultsForUrl:_urlSources[type]];
		if(resultsFromCache){
			block([self orderData:resultsFromCache byType:order]);
		}
		else{
			failBlock(error);
		}
	}];
	
}

- (NSArray *)orderData:(NSArray<ResultItem *> *) arr byType:(ContentOrderType)type{
	if(type == ContentOrderTypeDeparture){
		return [arr sortedArrayUsingSelector:@selector(compareByDeparture:)];
	}
	else if(type == ContentOrderTypeArrival){
		return [arr sortedArrayUsingSelector:@selector(compareByArrival:)];
	}
	else if(type == ContentOrderTypeDuration){
		return [arr sortedArrayUsingSelector:@selector(compareByDuration:)];
	}
	else{
		return  arr;
	}
}
@end
