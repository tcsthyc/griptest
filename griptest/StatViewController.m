//
//  StatViewController.m
//  griptest
//
//  Created by Design318 on 15-3-8.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "StatViewController.h"

@interface StatViewController ()

@end

@implementation StatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    OperationButton *btn=[[[NSBundle mainBundle] loadNibNamed:@"OperationButton" owner:self options:nil] lastObject];
    [btn setFrame:self.mView.bounds];
    [self.mView addSubview:btn];

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

@end
