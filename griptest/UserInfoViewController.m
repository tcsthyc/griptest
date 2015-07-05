//
//  UserInfoViewController.m
//  griptest
//
//  Created by MaggieWei on 15-7-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserUtils.h"
#import "UserInfoTableViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

UserInfoTableViewController * userInfoTabelViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"userInfoTableEmbededSegue"]) {
        userInfoTabelViewController = (UserInfoTableViewController *) [segue destinationViewController];
    }
}

- (IBAction)userLogoutClicked:(id)sender {
    [UserUtils logout];
    [userInfoTabelViewController refreshLabels];
}
@end
