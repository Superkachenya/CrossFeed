//
//  NSString+CFStringExtension.h
//  CrossFeed
//
//  Created by Danil on 11/12/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CFDStringExtension)

+ (NSString *)configureLastActivityWithDate:(NSDate *)date modified:(BOOL)modified answered:(BOOL)answered;
+ (NSString *)getGeographicalAreaFromString:(NSString *)string;

@end
