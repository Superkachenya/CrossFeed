//
//  CFBBCTableViewCell.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDBBCTableViewCell.h"
#import "CFDBBCArticle.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+CFDDateConverter.h"
#import "NSString+CFDStringExtension.h"

@interface CFDBBCTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *feedImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *geographicalAreaLabel;

@end

@implementation CFDBBCTableViewCell

#pragma mark - Public

- (void)configureCellWithArticle:(CFDBBCArticle *)article {
    
    [self.feedImageView sd_setImageWithURL:[NSURL URLWithString:article.thumbnaleUrl]];
    self.titleLabel.text = article.title;
    self.descriptionLabel.text = article.articleDescription;
    self.pubDateLabel.text = [article.pubDate stringFromDate];
    self.geographicalAreaLabel.text = [NSString getGeographicalAreaFromString:article.link];
}

@end
