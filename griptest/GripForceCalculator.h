//
//  GripForceCalculator.h
//  griptest
//
//  Created by Design318 on 15-3-9.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataUnit.h"

@interface GripForceCalculator : NSObject
@property(nonatomic,readonly) float maxForceTotal;
@property(nonatomic,readonly) float maxForceIndex;
@property(nonatomic,readonly) float maxForceMiddle;
@property(nonatomic,readonly) float maxForceRing;
@property(nonatomic,readonly) float maxForceLittle;
-(void)pushData:(DataUnit *)du;
@end
