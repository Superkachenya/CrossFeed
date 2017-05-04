//
//  CFNetworkManager.m
//  CrossFeed
//
//  Created by Danil on 11/3/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDStackOverflowNetworkManager.h"
#import "CFDStackOverflowPost.h"

const struct CFDApiPaths CFDApiPaths = {
    .baseURL = @"https://api.stackexchange.com/2.2/",
    .questionsURL = @"questions"
};

@interface CFDStackOverflowNetworkManager ()

@property (strong, nonatomic) NSDictionary *requiredParameters;

@end

@implementation CFDStackOverflowNetworkManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static CFDStackOverflowNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [CFDStackOverflowNetworkManager new];
        sharedManager.requiredParameters =  @{@"order":@"desc",
                                               @"sort":@"creation",
                                               @"site":@"stackoverflow"};
    });
    return sharedManager;
}

#pragma mark - Public

- (NSURLSessionDataTask *)getQuestionsWithCompletion:(CFDSuccessErrorCompletionBlock)completion {
    return [self GET:CFDApiPaths.questionsURL parameters:nil completion:^(id responseObject, NSError *error) {
        if (completion) {
            if (!error) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject[@"items"] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *result = [NSMutableArray new];
                        for (NSDictionary *dict in responseObject[@"items"]) {
                            CFDStackOverflowPost *post = [[CFDStackOverflowPost alloc] initWithDictionary:dict];
                            [result addObject:post];
                        }
                        completion(result.copy, nil);
                    }
                }  else {
                    NSLog(@"Response has unexpectable type: %@", [responseObject class]);
                }
            } else {
                completion(nil, error);
            }
        }
            }];
}

#pragma mark - Basic HTTP Routines:

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        NSURL *baseURL = [NSURL URLWithString:CFDApiPaths.baseURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        _httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _httpSessionManager;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   completion:(CFDSuccessErrorCompletionBlock)completion {
    return [self.httpSessionManager GET:URLString
                             parameters:self.requiredParameters
                               progress:^(NSProgress * _Nonnull downloadProgress) {}
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        if (completion) {
                                                completion(responseObject, nil);
                                        }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if (completion) {
                                        completion(nil, error);
                                    }
                                }];
}

@end
