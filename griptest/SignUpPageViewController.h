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
#import "ZCSAvatarCaptureController.h"

@interface SignUpPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ZCSAvatarCaptureControllerDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)registerClicked:(id)sender;
- (IBAction)takePhotoClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *infoTable;
@property (weak, nonatomic) IBOutlet UIButton *captureBtn;
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end
