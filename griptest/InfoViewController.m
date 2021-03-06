//
//  InfoViewController.m
//  griptest
//
//  Created by maggiewei on 15/6/10.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "InfoViewController.h"
#import "APIUtils.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize query;
@synthesize infoWebView;
@synthesize statusIcon;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = query;
    [self.infoWebView setDelegate:self];
    
    [self.statusIcon setHidesWhenStopped:YES];
    [self.statusIcon startAnimating];
    
    [self initWebView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webview
-(void)initWebView{
    NSString *targetAddress = [NSString stringWithFormat:@"info?page=%@",[query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *infoPageAddress = [APIUtils apiAddress:targetAddress];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:infoPageAddress]];
    [infoWebView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - webview protocol

//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [self.statusIcon startAnimating];
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.statusIcon stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.statusIcon stopAnimating];
}

@end
