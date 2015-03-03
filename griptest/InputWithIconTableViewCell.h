//
//  InputWithIconTableViewCell.h
//  griptest
//
//  Created by MaggieWei on 15-3-3.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputWithIconTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UITextField *inputTextView;

@end
