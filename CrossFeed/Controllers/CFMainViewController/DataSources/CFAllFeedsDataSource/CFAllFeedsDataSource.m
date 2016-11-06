//
//  CFAllFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFAllFeedsDataSource.h"
#import "CFMainViewController.h"
#import "CFStackOverflowTableViewCell.h"
#import "CFBBCTableViewCell.h"

#import "CFStackOverflowNetworkManager.h"
#import "CFBBCNetworkManager.h"
#import "CFBBCArticle.h"
#import "CFStackOverflowPost.h"

@interface CFAllFeedsDataSource ()

@property (weak, nonatomic) IBOutlet CFMainViewController *viewController;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSArray *stackOverflowPostsArray;
@property (strong, nonatomic) NSArray *bbcNewsArray;

@end

@implementation CFAllFeedsDataSource

- (instancetype)init {
    if (self = [super init]) {
        [self loadDataFromWeb];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSourceArray[indexPath.row] isKindOfClass:[CFBBCArticle class]]) {
        CFBBCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFBBCTableViewCell class]) forIndexPath:indexPath];
        [cell configureCellWithArticle:self.dataSourceArray[indexPath.row]];
        return cell;
    } else {
        CFStackOverflowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFStackOverflowTableViewCell class]) forIndexPath:indexPath];
        [cell configureCellWithPost:self.dataSourceArray[indexPath.row]];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0;
}

#pragma mark - Private

- (void)loadDataFromWeb {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CFStackOverflowNetworkManager sharedInstance] getQuestionsWithCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            _stackOverflowPostsArray = (NSArray *)responseObject;
        } else {
            [_viewController createAlertForError:error];
        }
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [[CFBBCNetworkManager sharedInstance] getBBCNewsFeedWithCompletion:^(id result) {
        _bbcNewsArray = result;
        dispatch_group_leave(group);
    }];
    __weak typeof(self)weakSelf = self;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [weakSelf mergeAllPostsInOneDataSource];
    });
}

- (void)mergeAllPostsInOneDataSource {
    NSMutableArray *tempArray = self.stackOverflowPostsArray.mutableCopy;
    [tempArray addObjectsFromArray:self.bbcNewsArray];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pubDate" ascending:NO];
    self.dataSourceArray = [tempArray sortedArrayUsingDescriptors:@[descriptor]];
    self.viewController.successBlock();
}

@end
