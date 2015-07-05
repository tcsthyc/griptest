//
//  APIUtils.m
//  griptest
//
//  Created by maggiewei on 15/6/7.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "APIUtils.h"

@implementation APIUtils

//static NSString *base = @"http://192.168.31.193:8000/api/";
static NSString *base = @"http://121.40.219.210:8000/api/";
static NSString *version=@"";

+(NSString*)apiAddress: (NSString*)name{
    return [NSString stringWithFormat:@"%@%@%@",base,version,name];
}

+(NSString*)getTipsURL{
    return [self apiAddress:@"tips"];
}

/*
 * not implemented yet
 */
+(NSString*)getTipsURLWithParams:(NSMutableDictionary *)params{
    return @"";
}


@end
