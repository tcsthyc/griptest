//
//  OperationButton.m
//  griptest
//
//  Created by Design318 on 15-3-8.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "OperationButton.h"

@implementation OperationButton
@synthesize valueLabel;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

UILabel *startLabel;
UILabel *hintLabel;

- (OperationButton *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        startLabel=(UILabel *)[self viewWithTag:3];
        hintLabel=(UILabel *)[self viewWithTag:1];
        self.valueLabel=(UILabel *)[self viewWithTag:2];
        [self changeStatus:toStart];
    }
    return self;
}

- (OperationButton *)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        startLabel=(UILabel *)[self viewWithTag:3];
        hintLabel=(UILabel *)[self viewWithTag:1];
        self.valueLabel=(UILabel *)[self viewWithTag:2];
        [self changeStatus:toStart];
    }
    return self;
}

-(void)changeStatus:(enum ListeningStatus)status{
    switch (status) {
        case toStart:
            //startLabel.alpha=1;
            //hintLabel.alpha=0;
            //valueLabel.alpha=0;
            [startLabel setHidden:NO];
            [hintLabel setHidden:YES];
            [valueLabel setHidden:YES];
            break;
        case listening:
            [valueLabel setHidden:NO];
            [hintLabel setHidden:NO];
            [startLabel setHidden:YES];
            //startLabel.alpha=0;
            //hintLabel.alpha=1;
            //valueLabel.alpha=1;
            break;
        case stopped:
            break;
        default:
            break;
    }
}

@end
