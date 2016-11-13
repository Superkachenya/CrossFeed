//
//  CFStackOverflowFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDStackOverflowFeedsDataSource.h"
#import "CFDStackOverflowTableViewCell.h"

#import "CFDMainViewController.h"
#import "CFDStackOverflowNetworkManager.h"
#import "CFDStackOverflowPost.h"

@interface CFDStackOverflowFeedsDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CFDMainViewController *viewController;
@property (strong, nonatomic) NSArray<CFDStackOverflowPost *> *dataSourceArray;

@end

@implementation CFDStackOverflowFeedsDataSource

#pragma mark - UITableViewDataSource

- (instancetype)init {
    
    if (self = [super init]) {
        [[CFDStackOverflowNetworkManager sharedInstance] getQuestionsWithCompletion:^(id responseObject, NSError *error) {
            if (!error) {
                _dataSourceArray = (NSArray *)responseObject;
                _viewController.successBlock();
            } else {
                [_viewController createAlertForError:error];
            }
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CFDStackOverflowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFDStackOverflowTableViewCell class])
                                                                         forIndexPath:indexPath];
    [cell configureCellWithPost:self.dataSourceArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.viewController.selectedService = kCFDStackOverflowTitle;
    self.viewController.selectedLink = self.dataSourceArray[indexPath.row].link;
    [self.viewController performSegueWithIdentifier:toCFDDetailsVCSegue sender:self.viewController];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
