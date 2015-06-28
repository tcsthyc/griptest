//
//  UserSexAndBdSelectVC.h
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSexAndBdSelectVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

- (IBAction)maleSelected:(UIButton *)sender;
- (IBAction)femaleSelected:(UIButton *)sender;
- (IBAction)ageChanged:(UISlider *)sender;

@end
