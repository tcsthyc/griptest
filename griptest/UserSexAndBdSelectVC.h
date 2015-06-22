//
//  UserSexAndBdSelectVC.h
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSexAndBdSelectVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconMale;
@property (weak, nonatomic) IBOutlet UIImageView *iconFemale;
- (IBAction)ageChanged:(UISlider *)sender;

@end
