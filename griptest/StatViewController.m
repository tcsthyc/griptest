//
//  StatViewController.m
//  griptest
//
//  Created by Design318 on 15-3-8.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "StatViewController.h"
#import "AFNetworking.h"
#import "APIUtils.h"
#import "UserUtils.h"

#define BarColorBlue [UIColor colorWithRed:58 / 255.0 green:123 / 255.0 blue:195 / 255.0 alpha:1.0f]

@interface StatViewController ()
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property (nonatomic, retain) AFHTTPRequestOperationManager *httpManager;
@end

@implementation StatViewController



OperationButton *btn;
@synthesize barChart;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.httpManager = [AFHTTPRequestOperationManager manager];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy/MM/dd"];
    [self refreshTitle];
    [self initBarChart];
    [self requestDataOfDay:self.curDate];
}

-(void)refreshTitle {
    if([self isSameDay: self.curDate]){
        self.navigationItem.title = @"今天";
    }
    else{
        self.navigationItem.title = [_formatter stringFromDate:_curDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)operationButtonTapped{
    [btn changeStatus:listening];
    UILabel *label=btn.valueLabel;

    label.text=[NSString stringWithFormat:@"%d",[label.text intValue]+1];
}


#pragma mark - date picker

- (IBAction)calenderBtnClicked:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.3),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self refreshTitle];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
//    [self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
}

-(Boolean)isSameDay: (NSDate *)otherDate{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if (
        (int)(([otherDate timeIntervalSince1970] + timezoneFix)/(24*3600)) -
        (int)(([[NSDate date] timeIntervalSince1970] + timezoneFix)/(24*3600))
        == 0)
    {
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark - bar chart
- (void) initBarChart{
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].applicationFrame.size.width-20,[UIScreen mainScreen].applicationFrame.size.height-300)];
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%0.f",yValueParsed];
        return labelText;
    };
    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"食指",@"中指",@"无名指",@"小指"]];
    [self.barChart setYMaxValue:20.f];
    [self.barChart setYValues:@[@0,@0,@0,@0]];
    [self.barChart setStrokeColors:@[BarColorBlue,BarColorBlue,BarColorBlue,BarColorBlue]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = YES;
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    [self.view addSubview:self.barChart];
}

#pragma mark - request data & update ui
-(void) requestDataOfDay: (NSDate *)date{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"date": [NSNumber numberWithDouble:date.timeIntervalSince1970]}];
    [[[UserUtils alloc]init] addUserToParams:params];
    [self.httpManager GET:[APIUtils apiAddress:@"historicalData"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject valueForKey:@"succeed"]){
            NSDictionary *data = [responseObject valueForKey:@"data"];
            [self updateViewsWithData:data];
        }
        else{
            NSLog(@"internal error: %@",[responseObject valueForKey:@"error"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
//    [self.barChart updateChartData:@[@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30)]];
}


-(void)updateViewsWithData:(NSDictionary *)data{
    [self.barChart updateChartData:@[[data valueForKey:@"index"],[data valueForKey:@"middle"],[data valueForKey:@"ring"],[data valueForKey:@"little"]]];
    
    NSString *f_max = [data objectForKey:@"max"];
    NSString *f_ex = [data objectForKey:@"explosive"];
    NSString *f_en = [data objectForKey:@"endurance"];
    NSString *f_ave = [data objectForKey:@"average"];
    if(f_max!=nil){
        self.maxLabel.text =f_max;
    }
    if(f_ex!=nil){
        self.exLabel.text =f_ex;
    }
    if(f_en!=nil){
        self.enLabel.text =f_en;
    }
    if(f_ave!=nil){
        self.aveLabel.text=f_ave;
    }
}

@end
