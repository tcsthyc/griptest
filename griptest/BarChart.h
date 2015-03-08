//
//  BarChart.h
//  griptest
//
//  Created by hyc on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataReceiver.h"
#import "Queue.h"

@interface BarChart : UIView <DataReceivedDelegate>
@property (nonatomic,retain) DataUnit *currentData;
@end
