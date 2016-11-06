//
//  CFNetworkManager.m
//  CrossFeed
//
//  Created by Danil on 11/3/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFStackOverflowNetworkManager.h"
#import "CFStackOverflowPost.h"

const struct CFApiPaths CFApiPaths = {
    .baseURL = @"https://api.stackexchange.com/2.2/",
    .questionsURL = @"questions",
    .questionByIdURL = @"questions/{ids}",
    .answersByQuestionIdURL = @"questions/{ids}/answers"
};

@interface CFStackOverflowNetworkManager ()

@property (strong, nonatomic) NSDictionary *requiredParameters;

@end

@implementation CFStackOverflowNetworkManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static CFStackOverflowNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [CFStackOverflowNetworkManager new];
        sharedManager.requiredParameters =  @{@"order":@"desc",
                                               @"sort":@"creation",
                                               @"site":@"stackoverflow"};
    });
    return sharedManager;
}

#pragma mark - Public

- (NSURLSessionDataTask *)getQuestionsWithCompletion:(CFSuccessErrorCompletionBlock)completion {
    return [self GET:CFApiPaths.questionsURL parameters:nil completion:^(id responseObject, NSError *error) {
        if (completion) {
            if (!error) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if ([responseObject[@"items"] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *result = [NSMutableArray new];
                        for (NSDictionary *dict in responseObject[@"items"]) {
                            CFStackOverflowPost *post = [[CFStackOverflowPost alloc] initWithDictionary:dict];
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

- (NSURLSessionDataTask *)getQuestionById:(NSNumber *)questionId withCompletion:(CFSuccessErrorCompletionBlock)completion {
    NSString *apiPath = [CFApiPaths.questionByIdURL stringByReplacingOccurrencesOfString:@"{ids}" withString:questionId.stringValue];
    return [self GET:apiPath parameters:nil completion:^(id responseObject, NSError *error) {
        if (!error) {
            
        } else {
            
        }
    }];
}

- (NSURLSessionDataTask *)getAnswersByQuestionId:(NSNumber *)questionId withCompletion:(CFSuccessErrorCompletionBlock)completion {
    NSString *apiPath = [CFApiPaths.answersByQuestionIdURL stringByReplacingOccurrencesOfString:@"{ids}" withString:questionId.stringValue];
    return [self GET:apiPath parameters:nil completion:^(id responseObject, NSError *error) {
        if (!error) {
            
        } else {
            
        }
    }];
}

#pragma mark - Basic HTTP Routines:

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        NSURL *baseURL = [NSURL URLWithString:CFApiPaths.baseURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
        _httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _httpSessionManager;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    completion:(CFSuccessErrorCompletionBlock)completion {
    
    NSURLSessionDataTask *task = [self.httpSessionManager POST:URLString
                                                    parameters:self.requiredParameters
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
