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
#import "UserUtils.h"
#import "UserInfoModifyController.h"
#import "QiniuSDK.h"
//#import "KLCPopup.h"

@interface SignUpPageViewController ()
@property (strong, nonatomic) ZCSAvatarCaptureController *avatarCaptureController;
@property (strong,readwrite) UIImage *currentAvatarImage;
@property (nonatomic,readwrite) User *currentUser;
@property (nonatomic,readwrite) NSString *qnToken;
@end

@implementation SignUpPageViewController

@synthesize captureBtn;
@synthesize avatarView;
@synthesize registerBtn;
@synthesize hintLabel;

UITextField *currentTextField;
UITextField *nameTextField;
UITextField *phoneTextField;
UITextField *pswdTextField;
UITextField *pswd2TextField;
UILabel *progressLabel;
AFHTTPRequestOperationManager *httpManager;
UIAlertView *alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    httpManager = [AFHTTPRequestOperationManager manager];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    currentTextField=nil;
    self.currentUser = [User alloc];
    [self.infoTable registerNib:[UINib nibWithNibName:@"InputWithIconTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"inputWithIconCell"];
    self.avatarCaptureController = [[ZCSAvatarCaptureController alloc] init];
    self.avatarCaptureController.delegate = self;
//    self.avatarCaptureController.image = [UIImage imageNamed:@"camera"];
    [self.avatarView addSubview:self.avatarCaptureController.view];
    [registerBtn setTitle:@"注册中" forState:UIControlStateDisabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showHintWithText: (NSString *)text{
    self.hintLabel.text = text;
    if([self.hintLabel  isHidden]){
        [self.hintLabel setHidden:NO];
    }
}
-(void) hideHint{
    [self.hintLabel setHidden:YES];
}

- (void)showAlertView:(NSString*)msg{
    if(alertView==nil){
        alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
    }
    else{
        alertView.message=msg;
        [alertView show];
    }
}

-(void) getToken{
    __weak SignUpPageViewController* weakSelf=self;
    [httpManager GET:[APIUtils apiAddress:@"qiniu-token"]
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 if([[responseObject objectForKey:@"succeed"] boolValue]){
                     weakSelf.qnToken=[responseObject valueForKey:@"data"];
                     [weakSelf uploadAvatar];
                 }
                 else{
                     [weakSelf hideHint];
                     [weakSelf showAlertView:@"服务器错误，无法上传头像"];
                     [weakSelf.registerBtn setEnabled:YES];
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [weakSelf hideHint];
                 [weakSelf showAlertView:@"服务器错误，无法上传头像"];
                 [weakSelf.registerBtn setEnabled:YES];
             }
     ];
}

- (void)uploadAvatar{
    __weak SignUpPageViewController* weakSelf=self;
    [self showHintWithText:@"上传头像中……"];
    
    NSString *token = self.qnToken;
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(self.currentAvatarImage, 1.0) ;
    
    QNUploadOption *opt = [[QNUploadOption alloc] initWithProgessHandler:^(NSString *key, float percent) {
        progressLabel.text = [NSString stringWithFormat:@"正在上传头像: (%f)",percent];
    }];
    [upManager putData:data key:@"avatar" token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  [weakSelf showHintWithText:@"上传完成！"];
                  //TODO set avatar
                  [UserUtils saveUser:weakSelf.currentUser];
                  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GTMainStory" bundle: nil ];
                  UserInfoModifyController *vc=[storyboard instantiateViewControllerWithIdentifier:@"userInfoModifyVC"];
                  vc.user = weakSelf.currentUser;
                  [weakSelf presentViewController:vc animated:YES completion:nil];
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
              } option:opt];
    
}

#pragma mark - avartar controller delegate
- (void)imageSelected:(UIImage *)image {
    [captureBtn setImage:image forState:UIControlStateNormal];
    [captureBtn setImage:image forState:UIControlStateHighlighted];
    captureBtn.imageView.layer.cornerRadius=40;
    [avatarView setHidden:YES];
    [captureBtn setHidden:NO];
    self.currentAvatarImage = image;
}

- (void)imageSelectionCancelled {
    [avatarView setHidden:YES];
    [captureBtn setHidden:NO];
    NSLog(@"imageSelectionCancelled");
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
    predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
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
    if(![self checkParams]){
        [self showAlertView:@"请确保用户名和手机号有效,且两次密码一致！"];
        return;
    }
    __weak SignUpPageViewController *weakSelf=self;
    
    [self.registerBtn setEnabled:NO];
    [self showHintWithText:@"注册中……"];
    
    NSDictionary *params = @{@"username":nameTextField.text,@"password":pswdTextField.text,@"telephone":phoneTextField.text};
    [httpManager POST:[APIUtils apiAddress:@"user/register"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res: %@",responseObject);
        if([[responseObject objectForKey:@"succeed"] boolValue]){
            id data = [responseObject objectForKey:@"data"];
            weakSelf.currentUser.uid = [[data objectForKey:@"id"] stringValue];
            weakSelf.currentUser.username = nameTextField.text;
            weakSelf.currentUser.password = pswdTextField.text;
            weakSelf.currentUser.telephone = phoneTextField.text;
//            weakSelf.currentUser.avatar = [[data objectForKey:@"avatar"] stringValue];
            [weakSelf getToken];
            
        }
        else{
            [weakSelf showAlertView:[responseObject valueForKey:@"error"]];
            [weakSelf.registerBtn setEnabled:YES];
            [weakSelf hideHint];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"res: %@",error);

        [weakSelf showAlertView:@"网络错误"];
        [weakSelf.registerBtn setEnabled:YES];
        [weakSelf hideHint];
    }];
}

- (IBAction)takePhotoClicked:(id)sender {
    [captureBtn setHidden:YES];
    [avatarView setHidden:NO];
    [self.avatarCaptureController startCapture];
}
@end
