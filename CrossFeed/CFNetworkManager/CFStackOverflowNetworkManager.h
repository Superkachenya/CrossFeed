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

@interface CFStackOverflowNetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

extern const struct CFApiPaths {
    __unsafe_unretained NSString *baseURL;
    __unsafe_unretained NSString *questionsURL;
    __unsafe_unretained NSString *questionByIdURL;
    __unsafe_unretained NSString *answersByQuestionIdURL;
    
} CFApiPaths;

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)getQuestionsWithCompletion:(CFSuccessErrorCompletionBlock)completion;

- (NSURLSessionDataTask *)getQuestionById:(NSNumber *)questionId withCompletion:(CFSuccessErrorCompletionBlock)completion;

- (NSURLSessionDataTask *)getAnswersByQuestionId:(NSNumber *)questionId withCompletion:(CFSuccessErrorCompletionBlock)completion;

@end
