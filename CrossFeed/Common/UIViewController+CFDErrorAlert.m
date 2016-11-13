//
//  UIViewController+CFErrorAlert.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "UIViewController+CFDErrorAlert.h"

@implementation UIViewController (CFDErrorAlert)

- (void)createAlertForError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Something wrong" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:close];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
