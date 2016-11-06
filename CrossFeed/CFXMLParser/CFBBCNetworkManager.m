//
//  CFXMLParser.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFBBCNetworkManager.h"

#import "SHXMLParser.h"
#import "CFBBCArticle.h"

static NSString *const kBBCNewsFeedUrl = @"http://feeds.bbci.co.uk/news/rss.xml";

@interface CFBBCNetworkManager ()


@end

@implementation CFBBCNetworkManager

+ (instancetype)sharedInstance {
    static CFBBCNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [CFBBCNetworkManager new];
    });
    return sharedManager;
}

- (void)getBBCNewsFeedWithCompletion:(CFBBCNetworkCompletionBlock)completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSData *webServicesData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kBBCNewsFeedUrl]];
        SHXMLParser *parser         = [[SHXMLParser alloc] init];
        NSDictionary *resultObject   = [parser parseData:webServicesData];
        NSArray *dataArray      = [SHXMLParser getDataAtPath:@"rss.channel.item" fromResultObject:resultObject];
        NSMutableArray *result = [NSMutableArray new];
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CFBBCArticle *article = [[CFBBCArticle alloc] initWithDictionary:obj];
            [result addObject:article];
        }];
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
        [result sortUsingDescriptors:@[descriptor]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(result);
            }
        });
    });
}

@end
