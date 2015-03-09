//
//  GripForceCalculator.m
//  griptest
//
//  Created by Design318 on 15-3-9.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "GripForceCalculator.h"

@implementation GripForceCalculator

@synthesize maxForceTotal;
@synthesize maxForceIndex;
@synthesize maxForceMiddle;
@synthesize maxForceRing;
@synthesize maxForceLittle;

- (GripForceCalculator *)init
{
    self = [super init];
    if (self) {
        maxForceTotal=0;
        maxForceIndex=0;
        maxForceMiddle=0;
        maxForceRing=0;
        maxForceLittle=0;
    }
    return self;
}

-(void)pushData:(DataUnit *)du{
    float total=du.index+du.middle+du.ring+du.little;
    
    //change max value
    if(total>maxForceTotal){
        maxForceTotal=total;
    }
    
    if(du.index>maxForceIndex){
        maxForceIndex=du.index;
    }
    
    if(du.middle>maxForceMiddle){
        maxForceMiddle=du.middle;
    }
    
    if(du.ring>maxForceRing){
        maxForceRing=du.ring;
    }
    
    if(du.little>maxForceLittle){
        maxForceLittle=du.little;
    }
    
    //change explosive data for each channel
    
}


@end
