//
//  CircleImageView.m
//  ScalesForGravida
//
//  Created by Design318 on 15-1-18.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "CircleImageView.h"

@implementation CircleImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        [self clipCircle];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    if (self =[super initWithCoder:coder]) {
        [self clipCircle];
    }
    return self;
}

-(void)clipCircle
{
    //self.bounds=CGRectMake(0, 0, 100, 100);
    self.layer.masksToBounds = YES;
    //NSLog(@"frame width: %f,  height: %f",CGRectGetWidth(self.frame),CGRectGetHeight(self.frame));
    //NSLog(@"init");
    //NSLog(@"frame size width: %f,  height: %f",self.frame.size.width,self.frame.size.height);
    
    //NSLog(@"bounds width: %f,  height: %f",CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds));
    //NSLog(@"bounds size width: %f,  height: %f",self.bounds.size.width,self.bounds.size.height);
    
    self.layer.cornerRadius = CGRectGetWidth(self.bounds)/2.f;
}

/*-(void)didMoveToWindow{
    NSLog(@"win");
    NSLog(@"frame size width: %f,  height: %f",self.frame.size.width,self.frame.size.height);
}

-(void)didMoveToSuperview{
    NSLog(@"su");
    NSLog(@"frame size width: %f,  height: %f",self.frame.size.width,self.frame.size.height);
}*/

/*- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect runned");
    // Drawing code
}*/


@end
