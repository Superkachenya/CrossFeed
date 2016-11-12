//
//  NSString+CFStringExtension.m
//  CrossFeed
//
//  Created by Danil on 11/12/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "NSString+CFStringExtension.h"
#import "NSDate+CFDateConverter.h"

@implementation NSString (CFStringExtension)

+ (NSString *)configureLastActivityWithDate:(NSDate *)date modified:(BOOL)modified answered:(BOOL)answered {
    NSUInteger timeDifference = [date calculateTimeBetweenNowAndDate];
    NSString *stringBeggining = nil;
    NSString *stringEnd = nil;
    if (timeDifference < kCFSecsInMinute) {
        stringEnd = [NSString stringWithFormat:@"%ld secs ago", timeDifference];
    } else {
        timeDifference = timeDifference / kCFSecsInMinute;
        stringEnd = timeDifference == 1 ? [NSString stringWithFormat:@"%ld min ago", timeDifference] : [NSString stringWithFormat:@"%ld mins ago", timeDifference];
    }
    if (!answered && !modified) {
        stringBeggining = @"asked ";
    } else {
        if (answered) {
            stringBeggining = @"answered ";
        } else {
            stringBeggining = @"modified ";
        }
    }
    return [stringBeggining stringByAppendingString:stringEnd];
}

@end
