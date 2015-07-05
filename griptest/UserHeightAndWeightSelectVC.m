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
User *finalUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    finalUser=[UserUtils readUser];
    finalUser.height=170;
    finalUser.weight=60;
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
    finalUser.weight=sender.value;
}

- (IBAction)heightValueChanged:(UISlider *)sender {
    self.heightLabel.text=[NSString stringWithFormat:@"%d", (int)roundf(sender.value)];
    finalUser.height=sender.value;
}

- (IBAction)infoComplete:(id)sender {
    __weak UserHeightAndWeightSelectVC *weakSelf=self;
   
    NSDictionary *params = @{@"username":finalUser.username,
                             @"password":finalUser.password,
                             @"height":@(finalUser.height),
                             @"weight":@(finalUser.weight),
                             @"age":@(finalUser.age),
                             @"sex":@(finalUser.sex)};
    [httpManager POST:[APIUtils apiAddress:@"user/update"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"succeed"] boolValue]){
            [UserUtils saveUser:finalUser];
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"GTMainStory" bundle: nil ];
            TabBarRootViewController *tbvc = [storyboard instantiateViewControllerWithIdentifier:@"rootTabViewVC"];
            [weakSelf presentViewController:tbvc animated:YES completion:nil];
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseObject valueForKey:@"error"] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
    }];
}
@end
