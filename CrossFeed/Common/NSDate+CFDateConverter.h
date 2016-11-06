//
//  NSDate+CFDateFromString.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CFDateConverter)

+ (NSDate *)dateFromString:(NSString *)string;

- (NSString *)stringFromDate;

@end
