//
//  UserHeightAndWeightSelectVC.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserHeightAndWeightSelectVC.h"
#import "UserInfoModifyController.h"
#import "TabBarRootViewController.h"
#import "AFNetworking.h"
#import "APIUtils.h"
#import "UserUtils.h"

@interface UserHeightAndWeightSelectVC ()

@end

@implementation UserHeightAndWeightSelectVC

AFHTTPRequestOperationManager *httpManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)weightValueChanged:(UISlider *)sender {
    self.weightLabel.text=[NSString stringWithFormat:@"%d", (int)roundf(sender.value)];
    ((UserInfoModifyController *)self.navigationController).user.weight=sender.value;
}

- (IBAction)heightValueChanged:(UISlider *)sender {
    self.heightLabel.text=[NSString stringWithFormat:@"%d", (int)roundf(sender.value)];
    ((UserInfoModifyController *)self.navigationController).user.height=sender.value;
}

- (IBAction)infoComplete:(id)sender {
    __weak UserHeightAndWeightSelectVC *weakSelf=self;
    [httpManager POST:[APIUtils apiAddress:@"user/update"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject boolForKey:@"succeed"]){
            [UserUtils saveUser:((UserInfoModifyController *)weakSelf.navigationController).user];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"GTMainStory" bundle: nil ];
            TabBarRootViewController *tbvc = [storyboard instantiateViewControllerWithIdentifier:@"rootTabViewVC"];
            [weakSelf presentViewController:tbvc animated:YES completion:nil];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseObject valueForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}
@end
