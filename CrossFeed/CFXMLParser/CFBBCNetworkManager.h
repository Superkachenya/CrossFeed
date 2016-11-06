//
//  CFXMLParser.h
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CFBBCNetworkCompletionBlock)(id result);

@interface CFBBCNetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)getBBCNewsFeedWithCompletion:(CFBBCNetworkCompletionBlock)completion;

@end
