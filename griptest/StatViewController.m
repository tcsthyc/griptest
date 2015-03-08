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

OperationButton *btn;
int count=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    btn=[[[NSBundle mainBundle] loadNibNamed:@"OperationButton" owner:self options:nil] lastObject];
    [btn setFrame:self.mView.bounds];
    [self.mView addSubview:btn];
    UITapGestureRecognizer *operationBtnTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonTapped)];
    [btn addGestureRecognizer:operationBtnTap];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)operationButtonTapped{
    [btn changeStatus:listening];
    UILabel *label=btn.valueLabel;

    label.text=[NSString stringWithFormat:@"%d",[label.text intValue]+1];
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
