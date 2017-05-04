//
//  CFXMLParser.m
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDBBCNetworkManager.h"

#import "SHXMLParser.h"
#import "CFDBBCArticle.h"

static NSString *const kBBCNewsFeedUrl = @"http://feeds.bbci.co.uk/news/rss.xml";

@implementation CFDBBCNetworkManager

+ (instancetype)sharedInstance {
    static CFDBBCNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [CFDBBCNetworkManager new];
    });
    return sharedManager;
}

- (void)getBBCNewsFeedWithCompletion:(CFDBBCNetworkCompletionBlock)completion {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        NSData *webServicesData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kBBCNewsFeedUrl]];
        SHXMLParser *parser = [[SHXMLParser alloc] init];
        NSDictionary *resultObject = [parser parseData:webServicesData];
        NSArray *dataArray = [SHXMLParser getDataAtPath:@"rss.channel.item" fromResultObject:resultObject];
        NSMutableArray *result = [NSMutableArray new];
        for (NSDictionary *articleDict  in dataArray) {
            CFDBBCArticle *article = [[CFDBBCArticle alloc] initWithDictionary:articleDict];
            [result addObject:article];
        }
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
