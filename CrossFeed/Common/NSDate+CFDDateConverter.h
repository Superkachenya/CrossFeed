//
//  NSDate+CFDateFromString.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const kCFDSecsInMinute;

@interface NSDate (CFDDateConverter)

+ (NSDate *)dateFromString:(NSString *)string;

- (NSString *)stringFromDate;

- (NSInteger)calculateTimeBetweenNowAndDate;

@end
