//
//  CFStackOverflowPost.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDStackOverflowPost.h"

NSString *const kCFDStackOverflowTitle = @"StackOverflow";

@implementation CFDStackOverflowPost

#pragma mark - Initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _acceptedAnswerId = dictionary[@"accepted_answer_id"];
        _answerCount      = dictionary[@"answer_count"];
        _pubDate          = [self convertValueToDate:dictionary[@"creation_date"]];
        _answered         = dictionary[@"is_answered"];
        _lastActivityDate = [self convertValueToDate:dictionary[@"last_activity_date"]];
        _lastEditDate     = [self convertValueToDate:dictionary[@"last_edit_date"]];
        _link             = dictionary[@"link"];
        _owner            = dictionary[@"owner"];
        _questionId       = dictionary[@"question_id"];
        _score            = dictionary[@"score"];
        _tags             = dictionary[@"tags"];
        _title            = dictionary[@"title"];
        _viewCount        = dictionary[@"view_count"];
    }
    return self;
}

- (instancetype)init {
    return [self initWithDictionary:nil];
}

#pragma mark - DateConverter

- (NSDate *)convertValueToDate:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *convertValue = (NSNumber *)value;
        return [NSDate dateWithTimeIntervalSince1970:(convertValue.doubleValue)];
    }
    return nil;
}

@end
