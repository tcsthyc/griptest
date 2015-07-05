//
//  UserInfoTableViewController.h
//  griptest
//
//  Created by MaggieWei on 15-7-5.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bmiLabel;
@property (weak, nonatomic) IBOutlet UILabel *bfpLabel;
-(void)refreshLabels;

@end
