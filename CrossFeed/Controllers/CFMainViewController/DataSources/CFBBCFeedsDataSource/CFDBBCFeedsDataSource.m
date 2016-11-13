//
//  CFBBCFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDBBCFeedsDataSource.h"
#import "CFDBBCTableViewCell.h"

#import "CFDMainViewController.h"
#import "CFDBBCNetworkManager.h"
#import "CFDBBCArticle.h"

@interface CFDBBCFeedsDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CFDMainViewController *viewController;
@property (strong, nonatomic) NSArray <CFDBBCArticle *>*dataSourceArray;

@end

@implementation CFDBBCFeedsDataSource

- (instancetype)init {
    
    if (self = [super init]) {
        [[CFDBBCNetworkManager sharedInstance] getBBCNewsFeedWithCompletion:^(id result) {
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
    
    CFDBBCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFDBBCTableViewCell class]) forIndexPath:indexPath];
    [cell configureCellWithArticle:self.dataSourceArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.viewController.selectedService = kCFDBBCTitle;
    self.viewController.selectedLink = self.dataSourceArray[indexPath.row].link;
    [self.viewController performSegueWithIdentifier:toCFDDetailsVCSegue sender:self.viewController];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
