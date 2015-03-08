//
//  MeasureViewController.h
//  griptest
//
//  Created by MaggieWei on 15-3-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleImageView.h"
#import "DataReceiver.h"
#import "BarChart.h"
#import "OperationButton.h"

@interface MeasureViewController : UIViewController
//@property (weak, nonatomic) IBOutlet CircleImageView *operationButton;
@property (weak, nonatomic) IBOutlet BarChart *barChartView;
@property (weak, nonatomic) IBOutlet UIView *OperationButtonArea;


@end
