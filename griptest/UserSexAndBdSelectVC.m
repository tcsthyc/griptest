//
//  UserSexAndBdSelectVC.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserSexAndBdSelectVC.h"
#import "UserInfoModifyController.h"
#import "UserUtils.h"

@interface UserSexAndBdSelectVC ()

@end

@implementation UserSexAndBdSelectVC
@synthesize btnFemale;
@synthesize btnMale;
@synthesize ageLabel;

int age;
Sex sex;


- (void)viewDidLoad {
    [super viewDidLoad];
    sex=male;
    age=60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)femaleSelected:(UIButton *)sender {
    NSLog(@"female");
    sex = female;
}

- (IBAction)maleSelected:(id)sender {
    NSLog(@"male");
    sex = male;
}

- (IBAction)ageChanged:(UISlider *)sender {
    age = (int)sender.value;
    ageLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    User *user=[UserUtils readUser];
    user.sex = sex;
    user.age = age;
    [UserUtils saveUser:user];
}
@end
