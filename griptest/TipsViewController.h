//
//  TipsViewController.h
//  griptest
//
//  Created by maggiewei on 15/5/24.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TipsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tipsTableView;

@end
