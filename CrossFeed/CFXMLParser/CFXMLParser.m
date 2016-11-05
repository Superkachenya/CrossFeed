//
//  CFXMLParser.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFXMLParser.h"

#import "SHXMLParser.h"
#import "CFBBCArticle.h"

static NSString *const kBBCNewsFeedUrl = @"http://feeds.bbci.co.uk/news/rss.xml";

@interface CFXMLParser ()


@end

@implementation CFXMLParser

- (NSArray *)testArray {
    NSData *webServicesData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kBBCNewsFeedUrl]];
    SHXMLParser *parser         = [[SHXMLParser alloc] init];
    NSDictionary *resultObject   = [parser parseData:webServicesData];
    NSArray *dataArray      = [SHXMLParser getDataAtPath:@"rss.channel.item" fromResultObject:resultObject];
    NSMutableArray *result = [NSMutableArray new];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CFBBCArticle *article = [[CFBBCArticle alloc] initWithDictionary:obj];
        [result addObject:article];
    }];
    return result;
}

@end
