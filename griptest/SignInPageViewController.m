//
//  SignInPageViewController.m
//  griptest
//
//  Created by MaggieWei on 15-3-2.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "SignInPageViewController.h"
#import "AFNetworking.h"
#import "APIUtils.h"

@interface SignInPageViewController ()
@end

@implementation SignInPageViewController

UITextField *currentTextField;
UITextField *nameTextField;
UITextField *pswdTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    currentTextField=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

-(void)loginClicked:(id)sender{
    if (![self checkParams]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名和密码不能为空！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        NSDictionary *params=@{@"username":nameTextField.text,@"password":pswdTextField.text};
        AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
        [httpManager POST:[APIUtils apiAddress:@"login"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有注册吧" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }];
    }
    
}

-(BOOL)checkParams{
    NSString *username = nameTextField.text;
    NSString *pswd = pswdTextField.text;
    return ![username isEqualToString:@""] && ![pswd isEqualToString:@""];
}

#pragma mark - table data

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"iconInputCell"];
    switch (indexPath.row) {
        case 0:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.textview.placeholder=@"昵称/手机";
            cell.textview.delegate=self;
            nameTextField = cell.textview;
            break;
        case 1:
            cell.icon.image=[UIImage imageNamed:@"circle"];
            cell.textview.placeholder=@"密码";
            cell.textview.secureTextEntry=true;
            cell.textview.delegate=self;
            pswdTextField = cell.textview;
            break;
            
        default:
            break;
    }
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


@end
