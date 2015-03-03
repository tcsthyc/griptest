//
//  SignUpPageViewController.m
//  griptest
//
//  Created by MaggieWei on 15-3-3.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "SignUpPageViewController.h"

@interface SignUpPageViewController ()

@end

@implementation SignUpPageViewController

UITextField *currentTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    currentTextField=nil;
    [self.infoTable registerNib:[UINib nibWithNibName:@"InputWithIconTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"inputWithIconCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard operation
-(void) dismissKeyboard{
    if(currentTextField){
        [currentTextField resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self dismissKeyboard];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    currentTextField=textField;
}

#pragma mark - table data

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InputWithIconTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"inputWithIconCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.inputTextView.placeholder=@"昵称";
            break;
        case 1:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.inputTextView.placeholder=@"手机";
            cell.inputTextView.keyboardType=UIKeyboardTypePhonePad;
            break;
        case 2:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.inputTextView.placeholder=@"密码";
            cell.inputTextView.secureTextEntry=true;
            break;
        case 3:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.inputTextView.placeholder=@"确认密码";
            cell.inputTextView.secureTextEntry=true;
            break;
            
        default:
            break;
    }
    
    cell.inputTextView.delegate=self;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
