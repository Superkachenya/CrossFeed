//
//  CFStackOverflowTableViewCell.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFStackOverflowPost;

@interface CFStackOverflowTableViewCell : UITableViewCell

- (void)configureCellWithPost:(CFStackOverflowPost *)post;

@end
