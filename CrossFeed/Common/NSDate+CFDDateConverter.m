//
//  NSDate+CFDateFromString.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "NSDate+CFDDateConverter.h"

NSInteger const kCFDSecsInMinute = 60;

@implementation NSDate (CFDDateConverter)

+ (NSDate *)dateFromString:(NSString *)string {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    return [dateFormatter dateFromString:string];
}

- (NSString *)stringFromDate {
    return [NSDateFormatter localizedStringFromDate:self
                                          dateStyle:NSDateFormatterShortStyle
                                          timeStyle:NSDateFormatterMediumStyle];
}

- (NSInteger)calculateTimeBetweenNowAndDate {
    NSDate *now = [NSDate date];
    NSTimeInterval difference = [now timeIntervalSinceDate:self];
    return (long)difference;
}

@end
