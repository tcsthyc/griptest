//
//  User.h
//  griptest
//
//  Created by Design318 on 15-1-17.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//@interface User : NSManagedObject
@interface User : NSObject

typedef NS_ENUM (NSInteger, Sex){
    male = 0,
    female = 1,
    other = 2
};

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, readwrite) NSInteger height;
@property (nonatomic, readwrite) Sex sex;
@property (nonatomic, readwrite) NSInteger age;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, readwrite) float  weight;
@property (nonatomic, readwrite) float  body_fat_per;

@end
