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
NSTimer *timer;  // temp use

- (DataReceiver *)initWithHandler:(id <DataReceivedDelegate>)mHandler
{
    self = [super init];
    if (self) {
        self.handler=mHandler;
        timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void) startListening{
    [timer fire];
}

-(void)stopListening{
    [timer invalidate];
}

-(void)timerFired:(NSTimer *)timer{
    if(data==nil){
        data=[DataUnit alloc];
    }
    data.index=rand()%25;
    data.middle=rand()%25;
    data.ring=rand()%25;
    data.little=rand()%25;
    if(self.handler!=nil){
        [self.handler onDataReceived:data];
    }
}

@end
