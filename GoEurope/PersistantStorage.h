//
//  PersistantStorage.h
//  GoEurope
//
//  Created by Mykyta Karpyshyn on 9/29/16.
//  Copyright © 2016 Mykyta Karpyshyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistantStorage : NSObject
- (BOOL)saveResults:(NSArray *)data forUrl:(NSString *)url;
- (NSArray *)getResultsForUrl:(NSString *)url;
@end
