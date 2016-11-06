//
//  CFBBCTableViewCell.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFBBCTableViewCell.h"
#import "CFBBCArticle.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+CFDateConverter.h"

@interface CFBBCTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;

@end

@implementation CFBBCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public

- (void)configureCellWithArticle:(CFBBCArticle *)article {
    [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:article.thumbnaleUrl]];
    self.titleLabel.text = article.title;
    self.descriptionLabel.text = article.articleDescription;
    self.pubDateLabel.text = [article.pubDate stringFromDate];
}

@end
