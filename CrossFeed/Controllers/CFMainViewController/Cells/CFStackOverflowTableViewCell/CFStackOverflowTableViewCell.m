//
//  CFStackOverflowTableViewCell.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFStackOverflowTableViewCell.h"
#import "CFStackOverflowPost.h"
#import "NSDate+CFDateConverter.h"
#import "NSString+CFStringExtension.h"

@interface CFStackOverflowTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActivityLabel;

@end

@implementation CFStackOverflowTableViewCell

#pragma mark - Public

- (void)configureCellWithPost:(CFStackOverflowPost *)post {
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
