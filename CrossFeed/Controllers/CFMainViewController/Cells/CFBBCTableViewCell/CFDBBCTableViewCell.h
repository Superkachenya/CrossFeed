//
//  CFBBCTableViewCell.h
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFDBBCArticle;

@interface CFDBBCTableViewCell : UITableViewCell

- (void)configureCellWithArticle:(CFDBBCArticle *)article;

@end
