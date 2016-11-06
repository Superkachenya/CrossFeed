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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf = self;
    self.tableView.dataSource = self.allFeedsDataSource;
    self.tableView.delegate = self.allFeedsDataSource;
    self.segmentedControl.selectedSegmentIndex = CFDataSourceTypeAll;
    self.successBlock = ^{
        [weakSelf.tableView reloadData];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
