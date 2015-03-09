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
NSTimer *timer;  // for temp use, generate random data
//CBCentralManager *mCM;

- (DataReceiver *)initWithHandler:(id <DataReceivedDelegate>)mHandler
{
    self = [super init];
    if (self) {
        self.handler=mHandler;
        //mCM=[[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
        
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

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            //The current state of the central manager is unknown; an update is imminent.
            //Available in iOS 5.0 and later.
            break;
        case CBCentralManagerStateResetting:
            //The connection with the system service was momentarily lost; an update is imminent.
            //Available in iOS 5.0 and later.
            break;
        case CBCentralManagerStateUnsupported:
            //The platform does not support Bluetooth low energy.
            //Available in iOS 5.0 and later.
            break;
        case CBCentralManagerStateUnauthorized:
            //The app is not authorized to use Bluetooth low energy.
            //Available in iOS 5.0 and later.
            break;
        case CBCentralManagerStatePoweredOff:
            //Bluetooth is currently powered off.
            //Available in iOS 5.0 and later.
            break;
        case CBCentralManagerStatePoweredOn:
            //Bluetooth is currently powered on and available to use.
            //Available in iOS 5.0 and later.
            break;
    
            
        default:
            break;
    }
}

@end
