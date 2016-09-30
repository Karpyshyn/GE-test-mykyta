//
//  ContentManager.h
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultItem.h"

typedef NS_ENUM(NSInteger, ContentTypeTransportType) {
	ContentTypeTransportTypeTrain,
	ContentTypeTransportTypeBus,
	ContentTypeTransportTypeFlight,
};

typedef NS_ENUM(NSInteger, ContentOrderType) {
	ContentOrderTypeDeparture,
	ContentOrderTypeArrival,
	ContentOrderTypeDuration,
};
@interface ContentManager : NSObject

+ (instancetype)sharedContentManager;
- (void)fetchResultsForTransportType:(ContentTypeTransportType)type order:(ContentOrderType)order withBlock:(void (^)(NSArray<ResultItem*> * arr))block failureBlock:(void (^)(NSError *error))failBlock;
@end
