//
//  CFAllFeedsDataSource.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDAllFeedsDataSource.h"
#import "CFDMainViewController.h"
#import "CFDStackOverflowTableViewCell.h"
#import "CFDBBCTableViewCell.h"

#import "CFDStackOverflowNetworkManager.h"
#import "CFDBBCNetworkManager.h"

#import "CFDBBCArticle.h"
#import "CFDStackOverflowPost.h"

@interface CFDAllFeedsDataSource () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet CFDMainViewController *viewController;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (strong, nonatomic) NSArray *stackOverflowPostsArray;
@property (strong, nonatomic) NSArray *bbcNewsArray;

@end

@implementation CFDAllFeedsDataSource

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
    
    if ([self.dataSourceArray[indexPath.row] isKindOfClass:[CFDBBCArticle class]]) {
        CFDBBCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFDBBCTableViewCell class]) forIndexPath:indexPath];
        [cell configureCellWithArticle:self.dataSourceArray[indexPath.row]];
        
        return cell;
    } else {
        CFDStackOverflowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CFDStackOverflowTableViewCell class]) forIndexPath:indexPath];
        [cell configureCellWithPost:self.dataSourceArray[indexPath.row]];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSourceArray[indexPath.row] isKindOfClass:[CFDBBCArticle class]]) {
        self.viewController.selectedService = kCFDBBCTitle;
    } else {
        self.viewController.selectedService = kCFDStackOverflowTitle;
    }
    self.viewController.selectedLink = [self.dataSourceArray[indexPath.row] link];
    [self.viewController performSegueWithIdentifier:toCFDDetailsVCSegue sender:self.viewController];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private

- (void)loadDataFromWeb {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CFDStackOverflowNetworkManager sharedInstance] getQuestionsWithCompletion:^(id responseObject, NSError *error) {
        if (!error) {
            _stackOverflowPostsArray = (NSArray *)responseObject;
        } else {
            [_viewController createAlertForError:error];
        }
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [[CFDBBCNetworkManager sharedInstance] getBBCNewsFeedWithCompletion:^(id result) {
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
