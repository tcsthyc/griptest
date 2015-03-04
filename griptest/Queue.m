//
//  Queue.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "Queue.h"

@implementation Queue

@synthesize length;
@synthesize size;
@synthesize front;
@synthesize rear;

-(Queue *)initWithSize:(int)s
{
    self = [super init];
    if (self) {
        self.values=[NSMutableArray arrayWithCapacity:size];
        self.size=s;
        self.front=0;
        self.rear=0;
        self.length=0;
    }
    return self;
}

-(void)enqueue:(float)value{
    [self.values replaceObjectAtIndex:self.rear withObject:[NSNumber numberWithFloat:value]];
    
    if(length<size){
        length++;
        rear=(rear+1)%size;
    }else{
        front=(front+1)%size;
        rear=(rear+1)%size;
    }
}


@end

