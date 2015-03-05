//
//  Queue.m
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "Queue.h"

@implementation Queue

//@synthesize length;
@synthesize size;
//@synthesize front;
@synthesize rear;

-(Queue *)initWithSize:(int)s
{
    self = [super init];
    if (self) {
        self.size=s;
        self.values=[NSMutableArray arrayWithCapacity:size];
        for(int i=0;i<size;i++){
            [self.values addObject:[NSNumber numberWithFloat:0]];
        }
        self.rear=size-1;
    }
    return self;
}

-(void)enqueue:(float)value{
    rear=(rear+1)%size;
    [self.values replaceObjectAtIndex:self.rear withObject:[NSNumber numberWithFloat:value]];
}


@end

