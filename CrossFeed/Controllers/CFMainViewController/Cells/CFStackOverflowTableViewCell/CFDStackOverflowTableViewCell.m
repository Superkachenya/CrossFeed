//
//  CFStackOverflowTableViewCell.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDStackOverflowTableViewCell.h"
#import "CFDStackOverflowPost.h"
#import "NSDate+CFDDateConverter.h"
#import "NSString+CFDStringExtension.h"

@interface CFDStackOverflowTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActivityLabel;

@end

@implementation CFDStackOverflowTableViewCell

#pragma mark - Public

- (void)configureCellWithPost:(CFDStackOverflowPost *)post {
    
    self.authorLabel.text = post.owner[@"display_name"];
    self.titleLabel.text = post.title;
    if (post.lastEditDate) {
        self.lastActivityLabel.text = [NSString configureLastActivityWithDate:post.pubDate
                                        modified:YES
                                        answered:post.answered.boolValue];
    } else {
       self.lastActivityLabel.text = [NSString configureLastActivityWithDate:post.pubDate
                                        modified:NO
                                        answered:NO];
    }
    self.dateLabel.text = [post.pubDate stringFromDate];
}

@end
