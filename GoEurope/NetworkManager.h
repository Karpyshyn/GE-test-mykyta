//
//  NetworkManager.h
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkManager : NSObject
- (void)getByUrl:(NSString *)url
	successBlock:(void (^)(id responseObject))success
	failureBlock:(void (^)(NSError *error))failer;
@end
