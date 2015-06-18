//
//  SignUpPageViewController.h
//  griptest
//
//  Created by MaggieWei on 15-3-3.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginInfoTableViewCell.h"
#import "InputWithIconTableViewCell.h"

@interface SignUpPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)registerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *infoTable;

@end
