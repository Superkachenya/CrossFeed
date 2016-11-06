//
//  CFBBCArticle.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFBBCArticle.h"
#import "NSDate+CFDateConverter.h"

@implementation CFBBCArticle

#pragma mark - Initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _title = dictionary[@"title"];
        _articleDescription = dictionary[@"description"];
        _link = dictionary[@"link"];
        _guid = dictionary[@"guid"];
        _pubDate = [NSDate dateFromString:(NSString *)dictionary[@"pubDate"]];
        _thumbnaleUrl = dictionary[@"media:thumbnail"][@"url"];
    }
    return self;
}

- (instancetype)init {
    return [self initWithDictionary:nil];
}

@end
