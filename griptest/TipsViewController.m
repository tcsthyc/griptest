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

@interface TipsViewController ()

@end

@implementation TipsViewController

@synthesize tipsTableView;
AFHTTPRequestOperationManager *httpManager;
NSMutableArray *tipsArray;
NSInteger page;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tipsArray = [[NSMutableArray alloc] initWithCapacity:10];
     httpManager = [AFHTTPRequestOperationManager manager];
    
    
    __weak TipsViewController *weakSelf = self;
    [tipsTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    [tipsTableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    } position:SVPullToRefreshPositionBottom];
    tipsTableView.showsInfiniteScrolling=NO;
    [tipsTableView triggerPullToRefresh];
    
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

-(void)insertRowAtBottom{
    __weak TipsViewController *weakSelf = self;
    
    [httpManager GET:[APIUtils getTipsURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject valueForKey:@"succeed"]){
            NSArray *data = [responseObject valueForKey:@"data"];
            [tipsArray addObjectsFromArray:data];
            [weakSelf updateTableView:data.count];
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
    UITableViewCell *cell = [self.tipsTableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UILabel *qLabel=(UILabel*)[cell viewWithTag:1];
    UILabel *contentLabel=(UILabel*)[cell viewWithTag:2];
    id tipItem = [tipsArray objectAtIndex:indexPath.row];
    NSString *qStr=[[tipItem valueForKey:@"content"] valueForKey:@"q"];
    NSString *aStr=[[tipItem valueForKey:@"content"] valueForKey:@"a"];
    NSString *content=[NSString stringWithFormat:@"%@\n%@",qStr,aStr];
    qLabel.text=[tipItem valueForKey:@"title"];
    contentLabel.text= content;
    CGRect cellFrame = [cell frame];
    cellFrame.size.height = qLabel.frame.size.height + contentLabel.frame.size.height + 24;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
//}

-(void)updateTableView:(NSInteger)count{
    [tipsTableView beginUpdates];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i=tipsArray.count-count;i<tipsArray.count;i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [tipsTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [tipsTableView endUpdates];
//    [tipsTableView.infiniteScrollingView stopAnimating];
    [tipsTableView.pullToRefreshView stopAnimating];

}


@end
