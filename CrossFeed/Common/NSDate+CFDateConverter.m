//
//  NSDate+CFDateFromString.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "NSDate+CFDateConverter.h"

@implementation NSDate (CFDateConverter)

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

@end
