//
//  CFMainViewController.m
//  CrossFeed
//
//  Created by Danil on 11/6/16.
//  Copyright © 2016 DanilVoitenko. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFAllFeedsDataSource.h"
#import "CFBBCFeedsDataSource.h"
#import "CFStackOverflowFeedsDataSource.h"
#import "CFStackOverflowTableViewCell.h"
#import "CFBBCTableViewCell.h"

static CGFloat const kCFEstimatedRowHeight = 120.0;

typedef NS_ENUM(NSInteger, CFDataSourceType) {
    CFDataSourceTypeAll,
    CFDataSourceTypeBBC,
    CFDataSourceTypeStackOverflow
};

@interface CFMainViewController ()

@property (strong, nonatomic) IBOutlet CFAllFeedsDataSource<UITableViewDataSource, UITableViewDelegate> *allFeedsDataSource;
@property (strong, nonatomic) IBOutlet CFBBCFeedsDataSource<UITableViewDataSource, UITableViewDelegate> *bbcFeedsDataSource;
@property (strong, nonatomic) IBOutlet CFStackOverflowFeedsDataSource<UITableViewDataSource, UITableViewDelegate> *StackOverflowFeedsDataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation CFMainViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    self.tableView.dataSource = self.allFeedsDataSource;
    self.tableView.delegate = self.allFeedsDataSource;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = kCFEstimatedRowHeight;
    [self setupCellsToTableView];
    self.segmentedControl.selectedSegmentIndex = CFDataSourceTypeAll;
    self.successBlock = ^{
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - IBActions

- (IBAction)actionSegmentedControlValueChanged:(UISegmentedControl *)sender {
    [self.tableView setContentOffset:CGPointZero animated:NO];
    switch (sender.selectedSegmentIndex) {
        case CFDataSourceTypeAll:
            self.tableView.dataSource = self.allFeedsDataSource;
            self.tableView.delegate = self.allFeedsDataSource;
            [self.tableView reloadData];
            break;
        case CFDataSourceTypeBBC:
            self.tableView.dataSource = self.bbcFeedsDataSource;
            self.tableView.delegate = self.bbcFeedsDataSource;
            [self.tableView reloadData];
            break;
        case CFDataSourceTypeStackOverflow:
            self.tableView.dataSource = self.StackOverflowFeedsDataSource;
            self.tableView.delegate = self.StackOverflowFeedsDataSource;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - Helpers

- (void)setupCellsToTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CFStackOverflowTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier: NSStringFromClass([CFStackOverflowTableViewCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CFBBCTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier: NSStringFromClass([CFBBCTableViewCell class])];
}

@end
