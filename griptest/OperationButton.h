//
//  OperationButton.h
//  griptest
//
//  Created by Design318 on 15-3-8.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
enum ListeningStatus{
    toStart,listening,stopped
};

@interface OperationButton : UIView
@property UILabel *valueLabel;
-(void)changeStatus:(enum ListeningStatus)status;

@end
