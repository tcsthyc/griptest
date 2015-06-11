//
//  APIUtils.h
//  griptest
//
//  Created by maggiewei on 15/6/7.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIUtils : NSObject

+(NSString*)apiAddress: (NSString*)name;

+(NSString*)getTipsURL;
+(NSString*)getTipsURLWithParams:(NSMutableDictionary*) params;

@end
