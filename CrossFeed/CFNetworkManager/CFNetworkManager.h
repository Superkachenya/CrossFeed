//
//  CFNetworkManager.h
//  CrossFeed
//
//  Created by Danil on 11/3/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
typedef void (^CFSuccessErrorCompletionBlock)(id responseObject, NSError *error);

@interface CFNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;


- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   completion:(CFSuccessErrorCompletionBlock)completion;

@end
