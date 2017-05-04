//
//  CFMainViewController.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFDMainViewController.h"

#import "CFDAllFeedsDataSource.h"
#import "CFDBBCFeedsDataSource.h"
#import "CFDStackOverflowFeedsDataSource.h"

#import "CFDStackOverflowTableViewCell.h"
#import "CFDBBCTableViewCell.h"

#import "CFDDetailsViewController.h"

static CGFloat const kCFDEstimatedRowHeight = 120.0;

NSString *const toCFDDetailsVCSegue = @"toCFDDetailsVCSegue";

typedef NS_ENUM(NSInteger, CFDDataSourceType) {
    CFDDataSourceTypeAll,
    CFDDataSourceTypeBBC,
    CFDDataSourceTypeStackOverflow
};

@interface CFDMainViewController ()

@property (strong, nonatomic) IBOutlet CFDAllFeedsDataSource <UITableViewDataSource, UITableViewDelegate> *allFeedsDataSource;
@property (strong, nonatomic) IBOutlet CFDBBCFeedsDataSource <UITableViewDataSource, UITableViewDelegate> *bbcFeedsDataSource;
@property (strong, nonatomic) IBOutlet CFDStackOverflowFeedsDataSource <UITableViewDataSource, UITableViewDelegate> *stackOverflowFeedsDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation CFDMainViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.allFeedsDataSource;
    self.tableView.delegate = self.allFeedsDataSource;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = kCFDEstimatedRowHeight;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.segmentedControl.selectedSegmentIndex = CFDDataSourceTypeAll;
    
    __weak typeof(self)weakSelf = self;
    self.successBlock = ^{
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - IBActions

- (IBAction)actionSegmentedControlValueChanged:(UISegmentedControl *)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:NSNotFound inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    switch (sender.selectedSegmentIndex) {
        case CFDDataSourceTypeAll:
            self.tableView.dataSource = self.allFeedsDataSource;
            self.tableView.delegate = self.allFeedsDataSource;
            [self.tableView reloadData];
            break;
        case CFDDataSourceTypeBBC:
            self.tableView.dataSource = self.bbcFeedsDataSource;
            self.tableView.delegate = self.bbcFeedsDataSource;
            [self.tableView reloadData];
            break;
        case CFDDataSourceTypeStackOverflow:
            self.tableView.dataSource = self.stackOverflowFeedsDataSource;
            self.tableView.delegate = self.stackOverflowFeedsDataSource;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:toCFDDetailsVCSegue]) {
        CFDDetailsViewController *bbcArticleVC = segue.destinationViewController;
        bbcArticleVC.openedService = self.selectedService;
        bbcArticleVC.openedLink = self.selectedLink;
    }
}

@end
