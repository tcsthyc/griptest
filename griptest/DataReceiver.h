//
//  DataReceiver.h
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataUnit.h"
#import <CoreBluetooth/CoreBluetooth.h>

@protocol DataReceivedDelegate <NSObject>

@required
- (void)onDataReceived:(DataUnit *)data;

@end

@interface DataReceiver : NSObject <CBCentralManagerDelegate>
-(void)startListening;
-(void)stopListening;
- (DataReceiver *)initWithHandler:(id <DataReceivedDelegate>)mHandler;

@property (nonatomic,retain) id <DataReceivedDelegate> handler;
@end
