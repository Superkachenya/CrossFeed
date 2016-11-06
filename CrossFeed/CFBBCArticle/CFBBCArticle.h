//
//  CFBBCArticle.h
//  CrossFeed
//
//  Created by Danil on 11/5/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFBBCArticle : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *articleDescription;
@property (nonatomic, strong, readonly) NSDate *pubDate;
@property (nonatomic, strong, readonly) NSString *link;
@property (nonatomic, strong, readonly) NSString *guid;
@property (nonatomic, strong, readonly) NSString *thumbnaleUrl;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
