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

static NSUserDefaults *userDefaults;

-(UserUtils *)init{
    self = [super init];
    if(self){
        userDefaults = [NSUserDefaults standardUserDefaults];
//        [self readUser];
    }
    return self;
}

//-(void)saveUser:(User *)newUser{
//    if(newUser==nil){
//        return;
//    }
//
//    if(newUser.username!=nil) [userDefaults setObject:newUser.username forKey:@"name"];
//    if(newUser.password!=nil) [userDefaults setObject:newUser.password forKey:@"password"];
//    if(newUser.uid!=nil) [userDefaults setObject:newUser.uid forKey:@"uid"];
//    if(newUser.age) [userDefaults setInteger:newUser.age forKey:@"age"];
//    if(newUser.sex) [userDefaults setInteger:newUser.sex forKey:@"sex"];
//    if(newUser.height) [userDefaults setInteger:newUser.height forKey:@"height"];
//    if(newUser.weight) [userDefaults setFloat:newUser.weight forKey:@"weight"];
//    if(newUser.height) [userDefaults setFloat:newUser.body_fat_per forKey:@"body_fat_percentage"];
//    if(newUser.avatar) [userDefaults setObject:newUser.avatar forKey:@"avatar"];
//    if(newUser.telephone) [userDefaults setObject:newUser.telephone forKey:@"telephone"];
//
//    self.user = newUser;
//    
//}

+(void)saveUser:(User *)newUser{
    if(newUser==nil){
        return;
    }
    if(userDefaults==nil){
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    if(newUser.username!=nil) [userDefaults setObject:newUser.username forKey:@"username"];
    if(newUser.password!=nil) [userDefaults setObject:newUser.password forKey:@"password"];
    if(newUser.uid!=nil) [userDefaults setObject:newUser.uid forKey:@"uid"];
    if(newUser.age) [userDefaults setInteger:newUser.age forKey:@"age"];
    if(newUser.sex) [userDefaults setInteger:newUser.sex forKey:@"sex"];
    if(newUser.height) [userDefaults setInteger:newUser.height forKey:@"height"];
    if(newUser.weight) [userDefaults setFloat:newUser.weight forKey:@"weight"];
    if(newUser.height) [userDefaults setFloat:newUser.body_fat_per forKey:@"body_fat_percentage"];
    if(newUser.avatar) [userDefaults setObject:newUser.avatar forKey:@"avatar"];
    if(newUser.telephone) [userDefaults setObject:newUser.telephone forKey:@"telephone"];
}

//-(User *)readUser{
//    if(self.user==nil){
//        self.user = [User alloc];
//    }
//    
//    user.username = [userDefaults stringForKey:@"name"];
//    user.password = [userDefaults stringForKey:@"password"];
//    user.uid = [userDefaults stringForKey:@"uid"];
//    user.age = [userDefaults integerForKey:@"age"];
//    user.sex = [userDefaults integerForKey:@"sex"];
//    user.height = [userDefaults integerForKey:@"height"];
//    user.weight = [userDefaults floatForKey:@"weight"];
//    user.body_fat_per = [userDefaults floatForKey:@"body_fat_percentage"];
//    user.avatar = [userDefaults stringForKey:@"avatar"];
//    user.telephone = [userDefaults stringForKey:@"telephone"];
//    
//    return self.user;
//    
//}

+(User *)readUser{
    if(userDefaults==nil){
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    User *user=[User alloc];
    user.username = [userDefaults stringForKey:@"username"];
    user.password = [userDefaults stringForKey:@"password"];
    user.uid = [userDefaults stringForKey:@"uid"];
    user.age = [userDefaults integerForKey:@"age"];
    user.sex = [userDefaults integerForKey:@"sex"];
    user.height = [userDefaults integerForKey:@"height"];
    user.weight = [userDefaults floatForKey:@"weight"];
    user.body_fat_per = [userDefaults floatForKey:@"body_fat_percentage"];
    user.avatar = [userDefaults stringForKey:@"avatar"];
    user.telephone = [userDefaults stringForKey:@"telephone"];
    return user;
}

+(void)logout{
    if(userDefaults==nil){
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    [userDefaults setObject:@"" forKey:@"username"];
}

//-(BOOL)isUserLoggedIn{
//    return self.user && self.user.username && ![self.user.username isEqualToString:@""];
//}

+(BOOL)isUserLoggedIn{
    if(userDefaults==nil){
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    NSString *uname=[userDefaults stringForKey:@"username"];
    if(uname!=nil && ![uname isEqualToString:@""]){
        return YES;
    }
    else{
        return NO;
    }
}

+(void)addUser:(User *)user ToParams:(NSMutableDictionary *)params{
    if(userDefaults==nil){
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    User *cuser=(user==nil?[self readUser]:user);

    [params setValue:cuser.username forKey:@"username"];
    [params setValue:cuser.password forKey:@"pswd"];
}

@end
