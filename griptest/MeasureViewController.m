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
OperationButton *ob;

DataReceiver *dr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    measureStarted=NO;
    
    ob=[[[NSBundle mainBundle] loadNibNamed:@"OperationButton" owner:self options:nil] lastObject];
    [ob setFrame:self.OperationButtonArea.bounds];
    [self.OperationButtonArea addSubview:ob];
    UITapGestureRecognizer *operationBtnTapRec=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonTapped)];
    [ob addGestureRecognizer:operationBtnTapRec];
    
    dr=[[DataReceiver alloc]initWithHandler:self.barChartView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)operationButtonTapped{
    if(measureStarted){
        [ob changeStatus:stopped];
        [dr stopListening];
        measureStarted=NO;
    }
    else{
        [ob changeStatus:listening];
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
