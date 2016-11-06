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

@interface CFStackOverflowTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation CFStackOverflowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public

- (void)configureCellWithPost:(CFStackOverflowPost *)post {
    self.authorLabel.text = post.owner[@"display_name"];
    self.titleLabel.text = post.title;
    self.dateLabel.text = [post.pubDate stringFromDate];
}
@end
