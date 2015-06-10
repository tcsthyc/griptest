//
//  InfoViewController.h
//  griptest
//
//  Created by maggiewei on 15/6/10.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property(nonatomic,readwrite) NSString *query;
@property (weak, nonatomic) IBOutlet UIWebView *infoWebView;

@end
