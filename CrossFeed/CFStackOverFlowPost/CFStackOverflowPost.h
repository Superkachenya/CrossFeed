//
//  CFStackOverflowPost.h
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFStackOverflowPost : NSObject

@property (strong, nonatomic, readonly) NSNumber *acceptedAnswerId;
@property (strong, nonatomic, readonly) NSNumber *answerCount;
@property (strong, nonatomic, readonly) NSDate *pubDate;
@property (strong, nonatomic, readonly, getter=isAnswered) NSNumber *answered;
@property (strong, nonatomic, readonly) NSDate *lastActivityDate;
@property (strong, nonatomic, readonly) NSDate *lastEditDate;
@property (strong, nonatomic, readonly) NSString *link;
@property (strong, nonatomic, readonly) NSDictionary *owner;
@property (strong, nonatomic, readonly) NSNumber *questionId;
@property (strong, nonatomic, readonly) NSString *score;
@property (strong, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSNumber *viewCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
