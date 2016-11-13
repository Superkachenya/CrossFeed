//
//  CFNetworkManager.h
//  CrossFeed
//
//  Created by Danil on 11/3/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^CFDSuccessErrorCompletionBlock)(id responseObject, NSError *error);

@interface CFDStackOverflowNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

extern const struct CFDApiPaths {
    __unsafe_unretained NSString *baseURL;
    __unsafe_unretained NSString *questionsURL;
} CFDApiPaths;

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)getQuestionsWithCompletion:(CFDSuccessErrorCompletionBlock)completion;

@end
