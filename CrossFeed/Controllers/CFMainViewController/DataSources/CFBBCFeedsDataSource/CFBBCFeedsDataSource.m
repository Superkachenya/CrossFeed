//
//  CFBBCFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFBBCFeedsDataSource.h"
#import "CFBBCTableViewCell.h"

#import "CFMainViewController.h"
#import "CFBBCNetworkManager.h"

@interface CFBBCFeedsDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CFMainViewController *viewController;
@property (strong, nonatomic) NSArray *dataSourceArray;

@end

@implementation CFBBCFeedsDataSource

- (instancetype)init {
    if (self = [super init]) {
        [[CFBBCNetworkManager sharedInstance] getBBCNewsFeedWithCompletion:^(id result) {
            _dataSourceArray = result;
            _viewController.successBlock();
        }];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFBBCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFBBCTableViewCell class]) forIndexPath:indexPath];
    [cell configureCellWithArticle:self.dataSourceArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
