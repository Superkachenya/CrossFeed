//
//  CFMainViewController.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CFDErrorAlert.h"

typedef void(^CFDMainControllerCompletionBlock)();

extern NSString *const toCFDDetailsVCSegue;

@interface CFDMainViewController : UIViewController

@property (copy, nonatomic) CFDMainControllerCompletionBlock successBlock;

@property (strong, nonatomic) NSString *selectedService;
@property (strong, nonatomic) NSString *selectedLink;

@end
