//
//  NetworkManager.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager
- (void)getByUrl:(NSString *)url
	successBlock:(void (^)(id responseObject))success
	failureBlock:(void (^)(NSError *error))failer{

	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		NSLog(@"JSON: %@", responseObject);
		success(responseObject);
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		NSLog(@"Error: %@", error);
		failer(error);
	}];
}
@end
