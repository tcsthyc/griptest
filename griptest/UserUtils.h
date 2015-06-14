//
//  UserUtils.h
//  griptest
//
//  Created by maggiewei on 15/6/14.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserUtils : NSObject

@property(nonatomic,retain) User* user;
-(void) addUserToParams: (NSDictionary *)params;

@end
