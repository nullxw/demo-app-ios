//
//  RegistViewController.m
//  iOS-IMKit-demo
//
//  Created by Heq.Shinoda on 14-6-5.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RegistViewController.h"
#import "MMProgressHUD.h"
#import "RCHttpRequest.h"
#import "DemoUIConstantDefine.h"



@interface RegistViewController ()<UITextFieldDelegate,HttpConnectionDelegate>

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    UIView *aView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    [aView setBackgroundColor:[UIColor whiteColor]];
    
    self.view =aView;
    
}
-(void)initNavitionBar
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 6, 62, 22);
    UIImageView* backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigator_btn_back.png"]];
    backImg.frame = CGRectMake(-10, 0, 22, 22);
    [backBtn addSubview:backImg];
    UILabel* backText = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 40, 22)];
    backText.text = @"返回";
    backText.font = [UIFont systemFontOfSize:15];
    [backText setBackgroundColor:[UIColor clearColor]];
    [backText setTextColor:[UIColor whiteColor]];
    [backBtn addSubview:backText];
    [backBtn addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:leftButton];
}

-(void)backToLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *	@brief	键盘出现
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil] ;
    
}

/**
 *	@brief	键盘消失
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillHide:(NSNotification *)aNotification

{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    //创建导航条
//    [self setTitle:@"注册"];
    
    
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLab.font = [UIFont systemFontOfSize:18];
    [titleLab setBackgroundColor:[UIColor clearColor]];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=titleLab;
   
    titleLab.text = @"注册";
    
    [self.view setBackgroundColor:RGBCOLOR(230, 230, 230)];
    
    [self initNavitionBar];
    [self layoutAllSubView];
}

-(void)layoutAllSubView
{
    UIImageView* emailBG = [[UIImageView alloc] initWithFrame:CGRectMake(13.f, 13.f+(IOS_FSystenVersion>=7.0?64:0), 294.f, 38.f)];
    emailBG.backgroundColor = [UIColor whiteColor];
    emailBG.userInteractionEnabled = YES;
    emailBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    emailBG.layer.cornerRadius = 6.0;
    emailBG.layer.borderWidth = 1.2;
    [self.view addSubview:emailBG];
    
    UITextField *emailTF= [[UITextField alloc] initWithFrame:CGRectMake(13.f, 11.f, 268.f, 19.f)];
    emailTF.tag = Tag_EmailTextField;
    emailTF.returnKeyType = UIReturnKeyDone;
    emailTF.delegate = self;
    emailTF.placeholder = @"输入邮箱";
    emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    [emailBG addSubview:emailTF];
    
    
    UIImageView* passwordBG = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(emailBG.frame), CGRectGetMaxY(emailBG.frame)+11.f, CGRectGetWidth(emailBG.frame), CGRectGetHeight(emailBG.frame))];
    passwordBG.backgroundColor = [UIColor whiteColor];
    passwordBG.userInteractionEnabled = YES;
    passwordBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    passwordBG.layer.cornerRadius = 6.0;
    passwordBG.layer.borderWidth = 1.2;
    [self.view addSubview:passwordBG];
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(13.f, 11.f, 268.f, 19.f)];
    passwordTF.tag = Tag_TempPasswordTextField;
    passwordTF.returnKeyType = UIReturnKeyDone;
    passwordTF.secureTextEntry = YES;
    passwordTF.delegate = self;
    passwordTF.placeholder = @"输入密码（6-16个字符，区分大小写）";
    [passwordBG addSubview:passwordTF];
    
    UIImageView* usernameBG = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordBG.frame), CGRectGetMaxY(passwordBG.frame)+11.f, CGRectGetWidth(passwordBG.frame), CGRectGetHeight(passwordBG.frame))];
    usernameBG.backgroundColor = [UIColor whiteColor];
    usernameBG.userInteractionEnabled = YES;
    usernameBG.layer.cornerRadius = 6.0;
    usernameBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    usernameBG.layer.borderWidth = 1.2;
    [self.view addSubview:usernameBG];
    
    UITextField *userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(13.f, 11.f, 268.f, 19.f)];
    userNameTF.tag = Tag_AccountTextField;
    userNameTF.returnKeyType = UIReturnKeyDone;
    userNameTF.delegate = self;
    userNameTF.placeholder = @"输入昵称（4－12个字母）";
    [usernameBG addSubview:userNameTF];
    
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(13.f, CGRectGetMaxY(usernameBG.frame)+45.f, 294.f, 44.f);
    [registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"regist_view_reg_btn_bg.png"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"同意并注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:HEXCOLOR(0x585858) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:registerBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - RegisterBtnClicked Method
- (void)registerBtnClicked:(id)sender
{
    if ([self checkValidityTextField]) {
        
//        [self alertTitle:@"提示" message:@"资料填写完整可以进行注册请求" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
        [self registToFakeServer];
    }
    
}

/**
 *	@brief	验证文本框是否为空
 */
#pragma mark checkValidityTextField Null
- (BOOL)checkValidityTextField
{
    if ([(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"邮箱不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"用户名不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"用户密码不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    
    return YES;
    
}

#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case Tag_EmailTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if (![self isValidateEmail:textField.text]) {
                    
                    [self alertTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    return;
                }
            }
        }
            break;
        case Tag_TempPasswordTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 6) {
                    
                    [self alertTitle:@"提示" message:@"请输入6－16位的密码！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    return;
                }
                else if ([[textField text] length] >16)
                {
                    [self alertTitle:@"提示" message:@"请输入6－16位的密码！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    textField.text = [textField.text substringToIndex:16];
                    return;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - touchMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self allEditActionsResignFirstResponder];
}

#pragma mark - PrivateMethod
- (void)allEditActionsResignFirstResponder{
    
    //邮箱
    [[self.view viewWithTag:Tag_EmailTextField] resignFirstResponder];
    //用户名
    [[self.view viewWithTag:Tag_AccountTextField] resignFirstResponder];
    //temp密码
    [[self.view viewWithTag:Tag_TempPasswordTextField] resignFirstResponder];
    //确认密码
//    [[self.view viewWithTag:Tag_ConfirmPasswordTextField] resignFirstResponder];
}


-(UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label;
    
}

-(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:aDeleagte cancelButtonTitle:cancelName otherButtonTitles:otherbuttonName, nil];
    [alert show];
    return alert;
}

//利用正则表达式验证邮箱的合法性
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

-(void)registToFakeServer
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithStatus:@"正在提交注册……"];
    NSString* userName = (NSString*)[(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text];
    NSString* userEmail = [(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text];
    NSString* userPSWord= [(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    NSString* strParams = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",@"email",userEmail,@"password",userPSWord, @"username",userName];
    [[RCHttpRequest defaultHttpRequest] httpConnectionWithURL:[NSString stringWithFormat:@"%@reg",FAKE_SERVER] bodyData:[strParams dataUsingEncoding:NSUTF8StringEncoding] delegate:self];
}

#pragma mark - HttpConnectionDelegate
- (void)responseHttpConnectionSuccess:(RCHttpRequest *)request
{
    if(request.response.statusCode == 200)
    {
        NSError* error = nil;
        NSDictionary * regDataDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
        NSLog(@"%@",regDataDict);
        [MMProgressHUD dismissWithSuccess:@"注册成功！"];
        [self backToLogin];
    }
    else
    {
        [MMProgressHUD dismiss];
        NSLog(@"Connection Result:%@",request.response);
        [self alertTitle:@"提示" message:[NSString stringWithFormat:@"注册帐号失败 : %d",request.response.statusCode ] delegate:nil cancelBtn:@"确定" otherBtnName:nil];
    }
    
}

- (void)responseHttpConnectionFailed:(RCHttpRequest *)request didFailWithError:(NSError *)error
{
    [MMProgressHUD dismiss];
    [self alertTitle:@"提示" message:@"网络原因，注册帐号失败" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
}
@end
