//
//  GripForceCalculator.m
//  griptest
//
//  Created by Design318 on 15-3-9.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "GripForceCalculator.h"

@implementation GripForceCalculator

@synthesize enForceTotal;
@synthesize exForceTotal;
@synthesize maxForceTotal;

@synthesize maxForceIndex;
@synthesize maxForceMiddle;
@synthesize maxForceRing;
@synthesize maxForceLittle;

float formerDataTotal;
float ffDataTotal;
int dataCount;

//represent time units passed by, from last MVC record time to current time, will reset to 0 if new highest force was recorded.
int timeUnitCountFromMVCTotal;
int minTotalForceInEnduranceTest;

const float timeSpan=0.06904f;
const float enduraceTestTime=20.f;
int timeUnitsInEnduranceTest;

- (GripForceCalculator *)init
{
    self = [super init];
    if (self) {
        maxForceTotal=0;
        enForceTotal=0;
        exForceTotal=0;
        
        maxForceIndex=0;
        maxForceMiddle=0;
        maxForceRing=0;
        maxForceLittle=0;
        
        dataCount=0;
        timeUnitCountFromMVCTotal=0;
        minTotalForceInEnduranceTest=0;
        timeUnitsInEnduranceTest=(int)(enduraceTestTime/timeSpan);
    }
    return self;
}

-(void)pushData:(DataUnit *)du{
    float total=du.index+du.middle+du.ring+du.little;
    if(dataCount<3) dataCount++;
    timeUnitCountFromMVCTotal++;
 
    //change max value
    if(total>maxForceTotal){
        maxForceTotal=total;
        timeUnitCountFromMVCTotal=0;
        minTotalForceInEnduranceTest=maxForceTotal;
    }
    
    if(total<minTotalForceInEnduranceTest){
        minTotalForceInEnduranceTest=total;
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
    if(dataCount>=3){
        float k=(total-ffDataTotal)/(2*timeSpan);
        if(k>exForceTotal) exForceTotal=k;
    }
    
    //change endurance data for each channel
    if(timeUnitCountFromMVCTotal==timeUnitsInEnduranceTest){
        enForceTotal=maxForceTotal-minTotalForceInEnduranceTest;
    }
    
    
    ffDataTotal=formerDataTotal;
    formerDataTotal=total;
}


@end
