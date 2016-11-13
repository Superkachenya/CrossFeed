//
//  NSString+CFStringExtension.m
//  CrossFeed
//
//  Created by Danil on 11/12/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "NSString+CFDStringExtension.h"
#import "NSDate+CFDDateConverter.h"

@implementation NSString (CFDStringExtension)

+ (NSString *)configureLastActivityWithDate:(NSDate *)date modified:(BOOL)modified answered:(BOOL)answered {
    NSUInteger timeDifference = [date calculateTimeBetweenNowAndDate];
    NSString *stringBeggining = nil;
    NSString *stringEnd = nil;
    if (!answered && !modified) {
        stringBeggining = @"asked ";
    } else {
        if (answered) {
            stringBeggining = @"answered ";
        } else {
            stringBeggining = @"modified ";
        }
    }
    if (timeDifference < kCFDSecsInMinute) {
        stringEnd = [NSString stringWithFormat:@"%ld secs ago", timeDifference];
    } else {
        timeDifference = timeDifference / kCFDSecsInMinute;
        stringEnd = timeDifference == 1 ? [NSString stringWithFormat:@"%ld min ago", timeDifference] : [NSString stringWithFormat:@"%ld mins ago", timeDifference];
    }
    
    return [stringBeggining stringByAppendingString:stringEnd];
}

+ (NSString *)getGeographicalAreaFromString:(NSString *)string {
    NSString *checkedString = [string stringByReplacingOccurrencesOfString:@"http://www.bbc.co.uk/" withString:@""];
    if ([checkedString containsString:@"uk"]) {
        return @"United Kingdom";
    } else if ([checkedString containsString:@"us"]) {
        return @"United States";
    } else if ([checkedString containsString:@"europe"]) {
        return @"Europe";
    } else if ([checkedString containsString:@"asia"]) {
        return @"Asia";
    } else if ([checkedString containsString:@"africa"]){
        return @"Africa";
    } else if ([checkedString containsString:@"middle-east"]) {
        return @"Middle East";
    } else if ([checkedString containsString:@"latin-america"]) {
        return @"Latin America";
    } else if ([checkedString containsString:@"sport"]) {
        return @"Sport";
    } else if ([checkedString containsString:@"entertainment-arts"]) {
        return @"Entertainment & Arts";
    } else if ([checkedString containsString:@"magazine"]) {
        return @"Magazine";
    } else if ([checkedString containsString:@"in-pictures"]) {
        return @"In Pictures";
    } else if ([checkedString containsString:@"world"]) {
        return @"World";
    }
    return nil;
}

@end
