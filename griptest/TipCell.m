//
//  TipCell.m
//  griptest
//
//  Created by maggiewei on 15/6/9.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "TipCell.h"

@implementation TipCell
@synthesize qLabel;
@synthesize cLabel;
@synthesize marginBlock;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat availableLabelWidth = self.qLabel.frame.size.width;
    self.qLabel.preferredMaxLayoutWidth = availableLabelWidth;
    availableLabelWidth = self.cLabel.frame.size.width;
    self.cLabel.preferredMaxLayoutWidth = availableLabelWidth;
    [super layoutSubviews];
}

@end
