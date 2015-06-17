//
//  SignInPageViewController.h
//  griptest
//
//  Created by MaggieWei on 15-3-2.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginInfoTableViewCell.h"
#import "User.h"

@interface SignInPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)loginClicked:(id)sender;

@end
