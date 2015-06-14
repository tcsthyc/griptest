//
//  UserUtils.m
//  griptest
//
//  Created by maggiewei on 15/6/14.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "UserUtils.h"

@implementation UserUtils

@synthesize user;

NSUserDefaults *userDefaults;

-(UserUtils *)init{
    self = [super init];
    if(self){
        userDefaults = [NSUserDefaults standardUserDefaults];
        [self readUser];
    }
    return self;
}

-(void)saveUser:(User *)newUser{
    if(newUser==nil){
        return;
    }

    if(newUser.username!=nil) [userDefaults setObject:newUser.username forKey:@"name"];
    if(newUser.password!=nil) [userDefaults setObject:newUser.password forKey:@"password"];
    if(newUser.uid!=nil) [userDefaults setObject:newUser.uid forKey:@"uid"];
    if(newUser.age) [userDefaults setInteger:newUser.age forKey:@"age"];
    if(newUser.sex) [userDefaults setInteger:newUser.sex forKey:@"sex"];
    if(newUser.height) [userDefaults setInteger:newUser.height forKey:@"height"];
    if(newUser.weight) [userDefaults setFloat:newUser.weight forKey:@"weight"];
    if(newUser.height) [userDefaults setFloat:newUser.body_fat_per forKey:@"body_fat_percentage"];
    
    self.user = newUser;
    
}

-(User *)readUser{
    if(self.user==nil){
        self.user = [User alloc];
    }
    
    user.username = [userDefaults stringForKey:@"name"];
    user.password = [userDefaults stringForKey:@"password"];
    user.uid = [userDefaults stringForKey:@"uid"];
    user.age = [userDefaults integerForKey:@"age"];
    user.sex = [userDefaults integerForKey:@"sex"];
    user.height = [userDefaults integerForKey:@"height"];
    user.weight = [userDefaults floatForKey:@"weight"];
    user.body_fat_per = [userDefaults floatForKey:@"body_fat_percentage"];
    
    return self.user;
    
}

-(void)addUserToParams:(NSMutableDictionary *)params{
    [params setValue:self.user.username forKey:@"username"];
    [params setValue:self.user.password forKey:@"pswd"];
}

@end
