//
//  UserHeightAndWeightSelectVC.h
//  griptest
//
//  Created by MaggieWei on 15-3-4.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserHeightAndWeightSelectVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
- (IBAction)weightValueChanged:(UISlider *)sender;
- (IBAction)heightValueChanged:(UISlider *)sender;

@end
