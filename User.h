//
//  User.h
//  griptest
//
//  Created by Design318 on 15-1-17.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * body_fat_per;

@end
