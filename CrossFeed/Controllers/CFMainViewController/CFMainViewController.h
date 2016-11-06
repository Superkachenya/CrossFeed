//
//  CFMainViewController.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CFErrorAlert.h"

typedef void(^CFMainControllerCompletionBlock)();

@interface CFMainViewController : UIViewController

@property (copy, nonatomic) CFMainControllerCompletionBlock successBlock;

@end
