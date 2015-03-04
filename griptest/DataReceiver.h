//
//  DataReceiver.h
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataUnit.h"

@protocol DataReceivedDelegate <NSObject>

@required
- (void)onDataReceived:(DataUnit *)data;

@end

@interface DataReceiver : NSObject
-(void)startListening;
@property (nonatomic,retain) id <DataReceivedDelegate> handler;
@end
