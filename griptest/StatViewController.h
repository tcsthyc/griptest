//
//  StatViewController.h
//  griptest
//
//  Created by Design318 on 15-3-8.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationButton.h"
#import "THDatePickerViewController.h"
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface StatViewController : UIViewController <THDatePickerDelegate>

@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic) IBOutlet PNBarChart *barChart;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *exLabel;
@property (weak, nonatomic) IBOutlet UILabel *enLabel;
@property (weak, nonatomic) IBOutlet UILabel *aveLabel;

- (IBAction)calenderBtnClicked:(id)sender;

@end
