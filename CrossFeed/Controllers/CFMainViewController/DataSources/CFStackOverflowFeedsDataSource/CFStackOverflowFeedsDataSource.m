//
//  CFStackOverflowFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFStackOverflowFeedsDataSource.h"
#import "CFStackOverflowTableViewCell.h"

#import "CFMainViewController.h"
#import "CFStackOverflowNetworkManager.h"

@interface CFStackOverflowFeedsDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CFMainViewController *viewController;
@property (strong, nonatomic) NSArray *dataSourceArray;

@end

@implementation CFStackOverflowFeedsDataSource

#pragma mark - UITableViewDataSource

- (instancetype)init {
    if (self = [super init]) {
        [[CFStackOverflowNetworkManager sharedInstance] getQuestionsWithCompletion:^(id responseObject, NSError *error) {
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
    CFStackOverflowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFStackOverflowTableViewCell class])
                                                                         forIndexPath:indexPath];
    [cell configureCellWithPost:self.dataSourceArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
