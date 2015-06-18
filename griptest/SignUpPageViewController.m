//
//  SignUpPageViewController.m
//  griptest
//
//  Created by MaggieWei on 15-3-3.
//  Copyright (c) 2015年 FIDT. All rights reserved.
//

#import "SignUpPageViewController.h"
#import "AFNetworking.h"
#import "APIUtils.h"
#import "User.h"

@interface SignUpPageViewController ()

@end

@implementation SignUpPageViewController

UITextField *currentTextField;
UITextField *nameTextField;
UITextField *phoneTextField;
UITextField *pswdTextField;
UITextField *pswd2TextField;
AFHTTPRequestOperationManager *httpManager;


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

-(BOOL)checkParams{
    if(![pswdTextField.text isEqualToString:pswd2TextField.text]){
        return false;
    }
    
    NSString *regex = @"^[1][358][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isPhoneNumValid = [predicate evaluateWithObject:phoneTextField.text];
    if(!isPhoneNumValid){
        return false;
    }
    
    regex=@"\\w+";
    BOOL isNameStrValid = [predicate evaluateWithObject:nameTextField.text];
    if(!isNameStrValid){
        return false;
    }
    
    return true;
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
            cell.icon.image=[UIImage imageNamed:@"nickname"];
            cell.inputTextView.placeholder=@"昵称";
            nameTextField = cell.inputTextView;
            break;
        case 1:
            cell.icon.image=[UIImage imageNamed:@"phone"];
            cell.inputTextView.placeholder=@"手机";
            cell.inputTextView.keyboardType=UIKeyboardTypePhonePad;
            phoneTextField = cell.inputTextView;
            break;
        case 2:
            cell.icon.image=[UIImage imageNamed:@"lock-1"];
            cell.inputTextView.placeholder=@"密码";
            cell.inputTextView.secureTextEntry=true;
            pswdTextField = cell.inputTextView;
            break;
        case 3:
            cell.icon.image=[UIImage imageNamed:@"lock-2"];
            cell.inputTextView.placeholder=@"确认密码";
            cell.inputTextView.secureTextEntry=true;
            pswd2TextField = cell.inputTextView;
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

#pragma mark - click events
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClicked:(id)sender {
    __weak SignUpPageViewController *weakSelf=self;
    NSDictionary *params = @{@"username":nameTextField.text,@"password":pswdTextField.text};
    [httpManager POST:[APIUtils apiAddress:@"user/register"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject boolForKey:@"succeed"]){
            id data = [responseObject valueForKey:@"data"];
            User *user= [User alloc];
            user.uid = [data stringForKey:@"id"];
            user.username = nameTextField.text;
            user.password = pswdTextField.text;
            
            //TODO push view
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //TODO alert
    }];
}
@end
