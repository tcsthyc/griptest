//
//  UserHeightAndWeightSelectVC.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserHeightAndWeightSelectVC.h"

@interface UserHeightAndWeightSelectVC ()

@end

@implementation UserHeightAndWeightSelectVC

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
}

- (IBAction)heightValueChanged:(UISlider *)sender {
    self.heightLabel.text=[NSString stringWithFormat:@"%d", (int)roundf(sender.value)];
}
@end
