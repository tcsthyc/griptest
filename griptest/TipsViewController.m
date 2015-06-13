//
//  TipsViewController.m
//  griptest
//
//  Created by maggiewei on 15/5/24.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "TipsViewController.h"
#import "SVPullToRefresh.h"
#import "APIUtils.h"
#import "AFNetworking.h"
#import "TipCell.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

@synthesize tipsTableView;
AFHTTPRequestOperationManager *httpManager;
NSMutableArray *tipsArray;
NSInteger page;
TipCell *baseCell;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    baseCell = [self.tipsTableView dequeueReusableCellWithIdentifier:@"tipCell"];
    tipsArray = [NSMutableArray array];
    httpManager = [AFHTTPRequestOperationManager manager];
    
    __weak TipsViewController *weakSelf = self;
    
    [tipsTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];

    tipsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [tipsTableView.pullToRefreshView setTitle:@"更新完成" forState:SVPullToRefreshStateStopped];
    [tipsTableView.pullToRefreshView setTitle:@"更新全部" forState:SVPullToRefreshStateTriggered];
    [tipsTableView.pullToRefreshView setTitle:@"获取中" forState:SVPullToRefreshStateLoading];
    
    [tipsTableView triggerPullToRefresh];
    
    [tipsTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    
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
    __weak TipsViewController *weakSelf = self;
    
    [httpManager GET:[APIUtils getTipsURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject valueForKey:@"succeed"]){
            NSArray *data = [responseObject valueForKey:@"data"];
            [tipsArray removeAllObjects];
            [tipsTableView reloadData];
            [tipsArray addObjectsFromArray:data];
            [weakSelf updateTableView:data.count];
            [weakSelf.tipsTableView.pullToRefreshView stopAnimating];
        }
        else{
            NSLog(@"internal error: %@",[responseObject valueForKey:@"error"]);
            [weakSelf.tipsTableView.pullToRefreshView stopAnimating];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tipsTableView.pullToRefreshView stopAnimating];
    }];
    
}

-(void)insertRowAtBottom{
    __weak TipsViewController *weakSelf = self;
    
    [httpManager GET:[APIUtils getTipsURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject valueForKey:@"succeed"]){
            NSArray *data = [responseObject valueForKey:@"data"];
            [tipsArray addObjectsFromArray:data];
            [weakSelf updateTableView:data.count];
            [weakSelf.tipsTableView.infiniteScrollingView stopAnimating];
        }
        else{
            NSLog(@"internal error: %@",[responseObject valueForKey:@"error"]);
            [weakSelf.tipsTableView.infiniteScrollingView stopAnimating];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [weakSelf.tipsTableView.infiniteScrollingView stopAnimating];
    }];
}

#pragma mark - table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tipsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tipCell";
    TipCell *cell = [self.tipsTableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil){
        cell = [[TipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self loadCellContent:cell atIndexPath:indexPath];
    return cell;
}

-(void)loadCellContent:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UILabel *qLabel=(UILabel*)[cell viewWithTag:1];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:2];
    id tipItem = [tipsArray objectAtIndex:indexPath.row];
    NSString *qStr=[[tipItem valueForKey:@"content"] valueForKey:@"q"];
    NSString *aStr=[[tipItem valueForKey:@"content"] valueForKey:@"a"];
    NSString *content=[NSString stringWithFormat:@"%@\n%@",qStr,aStr];
    qLabel.text=[tipItem valueForKey:@"title"];
    contentLabel.text= content;
   //    CGSize c_size = [contentLabel sizeThatFits:CGSizeMake(contentLabel.frame.size.width, MAXFLOAT)];
//    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, c_size.height);
//    [contentLabel sizeToFit];
//    [contentLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width-16];
//    [qLabel setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width-61];
//    [contentLabel layoutIfNeeded];
//    [qLabel layoutIfNeeded];
    [cell layoutSubviews];
    UIView *marginView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, tipsTableView.frame.size.width, 9)];
    marginView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:marginView];
    
    NSLog(@"lable height: %f,%f",qLabel.frame.size.height,contentLabel.frame.size.height);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = baseCell;
    [self loadCellContent:cell atIndexPath:indexPath];
//    [cell.contentView layoutIfNeeded];
//    [cell updateConstraints];
    CGSize size=[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"heightforrow: %f",1+size.height);
    return 1+size.height;
}

-(void)updateTableView:(NSInteger)count{
    [tipsTableView beginUpdates];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i=tipsArray.count-count;i<tipsArray.count;i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [tipsTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tipsTableView endUpdates];
}


@end
