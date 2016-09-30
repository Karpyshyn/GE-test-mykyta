//
//  PersistantStorage.m
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import "PersistantStorage.h"

@implementation PersistantStorage

- (BOOL)saveResults:(NSArray *)data forUrl:(NSString *)url{
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * documentsDirectory = [paths firstObject];
	NSString * filePath = [documentsDirectory stringByAppendingPathComponent:@([url hash]).stringValue];

	return [NSKeyedArchiver archiveRootObject:data toFile:filePath];
}

- (NSArray *)getResultsForUrl:(NSString *)url{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths firstObject];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@([url hash]).stringValue];
	return [NSKeyedUnarchiver unarchiveObjectWithData: [NSData dataWithContentsOfFile: filePath]];
}
@end
