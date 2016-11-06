//
//  UIViewController+CFErrorAlert.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CFErrorAlert)

- (void)createAlertForError:(NSError *)error;

@end
