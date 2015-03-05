//
//  Queue.h
//  A queue with fixed capacity.
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
-(Queue *)initWithSize:(int)s;
-(void)enqueue:(float)value;
//-(float)dequeue;
//@property(nonatomic,readwrite) int front;
@property(nonatomic,readwrite) int rear;
@property(nonatomic,readwrite) int size;
//@property(nonatomic,readwrite) int length;
@property(nonatomic,readwrite) NSMutableArray *values;
@end
