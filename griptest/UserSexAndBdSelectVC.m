//
//  UserSexAndBdSelectVC.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserSexAndBdSelectVC.h"
#import "UserInfoModifyController.h"

@interface UserSexAndBdSelectVC ()

@end

@implementation UserSexAndBdSelectVC
@synthesize iconFemale;
@synthesize iconMale;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(sexIconTapped:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sexIconTapped:(UIGestureRecognizer*)gestureRecognizer{
    if(gestureRecognizer.view==iconMale){
        ((UserInfoModifyController*)self.navigationController).user.sex = male;
    }
    else{
        ((UserInfoModifyController*)self.navigationController).user.sex = female;
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

- (IBAction)ageChanged:(UISlider *)sender {
    ((UserInfoModifyController*)self.navigationController).user.age = (int)sender.value;
}
@end
