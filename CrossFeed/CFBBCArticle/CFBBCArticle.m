//
//  CFBBCArticle.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFBBCArticle.h"

@interface CFBBCArticle ()

@property (nonatomic, strong, readwrite) NSString *title;
@property (nonatomic, strong, readwrite) NSString *articleDescription;
@property (nonatomic, strong, readwrite) NSString *pubDate;
@property (nonatomic, strong, readwrite) NSString *link;
@property (nonatomic, strong, readwrite) NSString *guid;
@property (nonatomic, strong, readwrite) NSString *thumbnaleUrl;

@end

@implementation CFBBCArticle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.title = dictionary[@"title"];
        self.articleDescription = dictionary[@"description"];
        self.link = dictionary[@"link"];
        self.guid = dictionary[@"guid"];
        self.pubDate = dictionary[@"pubDate"];
        self.thumbnaleUrl = dictionary[@"media:thumbnail"][@"url"];
    }
    return self;
}

@end
