//
//  TipsViewController.m
//  griptest
//
//  Created by maggiewei on 15/5/24.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "TipsViewController.h"
#import "SVPullToRefresh.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

@synthesize tipsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    __weak TipsViewController *weakSelf = self;
    [tipsTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    [tipsTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    } position:SVPullToRefreshPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - pull to refresh
- (void) insertRowAtTop{
    
}

-(void)insertRowAtBottom{
    
}

@end
