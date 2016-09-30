//
//  ResultItem.h
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultItem : NSObject <NSCoding>
@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * logo;
@property(nonatomic,strong) NSString * departureTime;
@property(nonatomic,strong) NSString * arrivalTime;
@property(nonatomic,strong) NSNumber * numberOfChanges;
@property(nonatomic,strong) NSString * price;

@property(nonatomic,strong) NSString * durationString;
@property(nonatomic) NSInteger durationInMinutes;


- (NSComparisonResult)compareByDeparture:(ResultItem *)other;
- (NSComparisonResult)compareByArrival:(ResultItem *)other;
- (NSComparisonResult)compareByDuration:(ResultItem *)other;
@end
