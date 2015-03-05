//
//  MeasureViewController.m
//  griptest
//
//  Created by MaggieWei on 15-3-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "MeasureViewController.h"

@interface MeasureViewController ()

@end

@implementation MeasureViewController

BOOL measureStarted;

DataReceiver *dr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    measureStarted=NO;
    UITapGestureRecognizer *operationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonTapped)];
    [self.operationButton addGestureRecognizer:operationTap];
    
    dr=[[DataReceiver alloc]initWithHandler:self.barChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)operationButtonTapped{
    if(measureStarted){
        [dr stopListening];
        measureStarted=NO;
    }
    else{
        [dr startListening];
        measureStarted=YES;
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

@end
