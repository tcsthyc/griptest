//
//  DataReceiver.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "DataReceiver.h"

@implementation DataReceiver
DataUnit *data;
-(void) startListening{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)timerFired:(NSTimer *)timer{
    if(data==nil){
        data=[DataUnit alloc];
    }
    data.index=rand()%10+10;
    data.middle=rand()%10+10;
    data.ring=rand()%10+10;
    data.little=rand()%10+10;
    if(self.handler!=nil){
        [self.handler onDataReceived:data];
    }
}

@end
