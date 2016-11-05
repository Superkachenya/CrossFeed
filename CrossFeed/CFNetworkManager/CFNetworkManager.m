//
//  CFNetworkManager.m
//  CrossFeed
//
//  Created by Danil on 11/3/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFNetworkManager.h"

static NSString *const kBaseUrl = @"https://api.stackexchange.com/2.2/";

@implementation CFNetworkManager

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        NSURL *baseURL = [NSURL URLWithString:kBaseUrl];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        _httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _httpSessionManager;
}

#pragma mark - Basic HTTP Routines:

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    completion:(CFSuccessErrorCompletionBlock)completion {
    
    NSURLSessionDataTask *task = [self.httpSessionManager POST:URLString
                                                    parameters:parameters
                                                      progress:^(NSProgress * _Nonnull uploadProgress) {}
                                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                           if (completion) {
                                                               completion(responseObject, nil);
                                                           }
                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                           if (completion) {
                                                               completion(nil, error);
                                                           }
                                                       }];
    return task;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   completion:(CFSuccessErrorCompletionBlock)completion {
    return [self.httpSessionManager GET:URLString
                             parameters:parameters
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
