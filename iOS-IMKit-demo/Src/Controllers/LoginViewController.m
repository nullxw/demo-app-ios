//
//  LoginViewController.m
//  iOS-IMKit-demo
//
//  Created by Heq.Shinoda on 14-6-5.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "LoginViewController.h"
#import "RCUserInfo.h"

#import "RegistViewController.h"
#import "MMProgressHUD.h"

#import "DemoUIConstantDefine.h"

#import "UserDataModel.h"
#import "DemoCommonConfig.h"

/*
 *RONGCLOUD_IM_APPKEY说明： AppKey是应用与服务器通信的标识，请到http://www.rongcloud.cn申请。

 通信服务器的搭建可以参照<https://github.com/rongcloud/auth-service-nodejs>*
 */
#define NAVI_BAR_HEIGHT 44.0f


@interface LoginViewController () <RCIMFriendsFetcherDelegate, RCIMUserInfoFetcherDelegagte>
@property(nonatomic, strong) NSMutableArray *allFriendsArray;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)keyboardWillShow:(NSNotification *)aNotification

{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil] ;
    
}

- (void)keyboardWillHide:(NSNotification *)aNotification

{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil];
    
}
-(void)loadView
{
    [super loadView];
    UIView *aView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    [aView setBackgroundColor:[UIColor whiteColor]];
    
    self.view =aView;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:IMAGE_BY_NAMED(@"login_view_bg.jpg")]];
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     }
    //创建初始化页面
    [self layoutInitView];
    loginToken = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
    [super viewWillAppear:animated];
}

- (void)layoutInitView
{
    UIImageView* logoRongCloud = [[UIImageView alloc] initWithFrame:CGRectMake(103, 50, 114, 112)];
    [logoRongCloud setImage:IMAGE_BY_NAMED(@"login_view_logo.png")];
    [self.view addSubview:logoRongCloud];
    
    UIImageView* inputBgView = [[UIImageView alloc] initWithFrame:CGRectMake(28, CGRectGetMaxY(logoRongCloud.frame)+14, 264, 89)];
    inputBgView.userInteractionEnabled = YES;
//    [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5]
    UIImage* imageBg = IMAGE_BY_NAMED(@"input_bg.png");
    [inputBgView setImage:[imageBg stretchableImageWithLeftCapWidth:imageBg.size.width*0.5 topCapHeight:imageBg.size.height*0.5]];
    [self.view addSubview:inputBgView];
    UIImageView* splitLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 264, 1)];
    [splitLine setImage:IMAGE_BY_NAMED(@"split_line.png")];
    [inputBgView addSubview:splitLine];
    
    UIImageView* userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 11, 26, 26)];
    [userIcon setImage:IMAGE_BY_NAMED(@"user_icon.png")];
    [inputBgView addSubview:userIcon];
    UIImageView* passwordIcon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 11+44, 26, 26)];
    [passwordIcon setImage:IMAGE_BY_NAMED(@"password_icon.png")];
    [inputBgView addSubview:passwordIcon];
    
    UITextField *userTextField = [[UITextField alloc] initWithFrame:CGRectMake(46.f, 8, 210.f, 30.f)];
    userTextField.tag = Tag_EmailTextField;
    userTextField.textColor = [UIColor whiteColor];
    userTextField.returnKeyType = UIReturnKeyDone;
    userTextField.keyboardType = UIKeyboardTypeEmailAddress;
    userTextField.delegate = self;
    if ([userTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = HEXCOLOR(0xffffff);
        userTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        userTextField.placeholder = @"用户名";
    }
    [inputBgView addSubview:userTextField];
    userTextField.text = [self getDefaultUser];
    
    UITextField *psTextField = [[UITextField alloc] initWithFrame:CGRectMake(46.f, CGRectGetMaxY(userTextField.frame)+14, 210.f, 30.f)];
    psTextField.tag = Tag_TempPasswordTextField;
    psTextField.textColor = [UIColor whiteColor];
    psTextField.returnKeyType = UIReturnKeyDone;
    psTextField.secureTextEntry = YES;
    psTextField.delegate = self;
    if ([psTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = HEXCOLOR(0xffffff);
        psTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        psTextField.placeholder = @"密码";
    }
    [inputBgView addSubview:psTextField];
    psTextField.text = [self getDefaultUserPwd];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(CGRectGetMinX(inputBgView.frame), CGRectGetMaxY(inputBgView.frame)+20.0f, 265.f, 44.f);
    [loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_view_login_btn_bg.png"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:loginBtn];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(CGRectGetMinX(inputBgView.frame), CGRectGetMaxY(loginBtn.frame)+10, 265.f, 44.f);
    [registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_view_regist_btn_bg.png"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:HEXCOLOR(0x585858) forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
    [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:registerBtn];
    
    
    UILabel *bulidVersionLabel = [[UILabel alloc]initWithFrame:CGRectMake((320-240)/2, registerBtn.frame.origin.y+60, 240, 40)];
    [bulidVersionLabel setTextAlignment:NSTextAlignmentCenter];
    [bulidVersionLabel setBackgroundColor:[UIColor clearColor]];
    [bulidVersionLabel setTextColor:[UIColor whiteColor]];
    NSString * buildVer = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    NSLog(@"bulid ==>%@",buildVer);
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"version ==>%@",version);
    [bulidVersionLabel setText:[NSString stringWithFormat:@"Ver. %@",buildVer]];
    
    [self.view addSubview:bulidVersionLabel];
    
    
    
    
    UILabel *shortVersionLabel = [[UILabel alloc]initWithFrame:CGRectMake((320-160)/2, registerBtn.frame.origin.y+60+40, 160, 40)];
    [shortVersionLabel setTextAlignment:NSTextAlignmentCenter];
    [shortVersionLabel setBackgroundColor:[UIColor clearColor]];
    [shortVersionLabel setTextColor:[UIColor whiteColor]];

    NSString * shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [shortVersionLabel setText:[NSString stringWithFormat:@"Build %@",shortVersion]];
    
    [self.view addSubview:shortVersionLabel];
    
}

-(NSString*)getDefaultUser
{
    NSString* defaultUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"RC_LAST_USERNAME"];
    return defaultUser;
}

-(NSString*)getDefaultUserPwd
{
    NSString* defaultUserPwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"RC_LAST_USERPWD"];
    return defaultUserPwd;
}

-(void)setDefaultUser:(NSString*)user pwd:(NSString*)pwd
{
    if(user == nil)
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"RC_LAST_USERNAME"];
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"RC_LAST_USERPWD"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loginBtnClicked:(id)sender
{
    if ([self checkValidityTextField])
    {
        
        [self allEditActionsResignFirstResponder];
        [self loginToFakeServer];
    }
    NSString* userEmail = [(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text];
    NSString* userPSWord= [(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    [self setDefaultUser:userEmail pwd:userPSWord];
}

-(void)loginToFakeServer
{
    NSString* userEmail = [(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text];
    NSString* userPSWord= [(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    NSString* deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
    //----登录server----//
    NSString* strParams = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",@"email",userEmail,@"password",userPSWord, @"deviceid",(deviceToken==nil?@"":deviceToken)];

    self.loginRequest = [[RCHttpRequest alloc]init];
    self.loginRequest.tag = 1000;
    
    [self.loginRequest httpConnectionWithURL:[NSString stringWithFormat:@"%@login",FAKE_SERVER] bodyData:[strParams dataUsingEncoding:NSUTF8StringEncoding] delegate:self];

    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"正在登录" status:@"……" cancelBlock:^
     {
         //[weakHttpRequest cancelHttpRequest];
     }];

}
#pragma mark - RegisterBtnClicked Method
- (void)registerBtnClicked:(id)sender
{
    [self allEditActionsResignFirstResponder];
//    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
    RegistViewController* regVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
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
    if ([(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"用户密码不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if (![self isValidateEmail:[(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text]]) {
        
        [self alertTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        return NO;
    }
#if CHECK_PASSWORD_ENABLE
    if ([[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] length] < 6) {
        
        [self alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        return NO;
    }
#endif//CHECK_PASSWORD_ENABLE
    
    return YES;
    
}

#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
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
#if CHECK_PASSWORD_ENABLE
                if ([[textField text] length] < 6) {
                    
                    [self alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    return;
                }
#endif//CHECK_PASSWORD_ENABLE
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
    
    //用户名
    [[self.view viewWithTag:Tag_EmailTextField] resignFirstResponder];
    //密码
    [[self.view viewWithTag:Tag_TempPasswordTextField] resignFirstResponder];
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

#pragma mark - HttpConnectionDelegate
- (void)responseHttpConnectionSuccess:(RCHttpRequest *)request
{
    if (1000 == request.tag) {
        if(request.response.statusCode == 200)
        {
            NSError* error = nil;
            NSDictionary * regDataDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
            
            NSString* token = [regDataDict objectForKey:@"token"];
            loginToken = token;
            
            UserDataModel* curUser = [[UserDataModel alloc] initWithUserData:[NSString stringWithFormat:@"%d",[[regDataDict objectForKey:KUserDataModel_Key_UserID] intValue]] userName:[regDataDict objectForKey:KUserDataModel_Key_UserName] userNamePY:@"" portrait:@"" user_Email:[regDataDict objectForKey:KUserDataModel_Key_UserEmail]];
            [UserManager shareMainUser].mainUser = curUser;
            
            RCUserInfo *userInfo = [RCUserInfo new];
            userInfo.userId = [regDataDict objectForKey:KUserDataModel_Key_UserID];
            userInfo.name = [regDataDict objectForKey:KUserDataModel_Key_UserName];
            [self requestFriendsList];
        }
        else
        {
            [MMProgressHUD dismiss];
            NSLog(@"Connection Result:%@",request.response);
            [self alertTitle:@"提示" message:[NSString stringWithFormat:@"帐号或密码错误，无法登录 : %d",request.response.statusCode ] delegate:nil cancelBtn:@"确定" otherBtnName:nil];
        }

    }else{
        
        if(request.response.statusCode == 200)
        {
            NSError* error = nil;
            NSArray * regDataArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
            
            // NSString *str = [[NSString alloc]initWithData:connection.responseData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",regDataArray);
            //NSLog(@"response Data string: %@",[NSString stringWithUTF8String:[connection.responseData bytes]]);
            //NSLog(@"%@",str);
            
            self.allFriendsArray = [[NSMutableArray alloc]initWithCapacity:0];
            for(int i= 0;i <regDataArray.count;i++){
                
                NSDictionary *dic = [regDataArray objectAtIndex:i];
                RCUserInfo *userInfo = [RCUserInfo new];
                NSNumber *idNum = [dic objectForKey:@"id"];
                userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                userInfo.portraitUri = [dic objectForKey:@"portrait"];
                userInfo.name = [dic objectForKey:@"username"];
                //----好友列表中将自己排除掉。
                if([[UserManager shareMainUser].mainUser.userId isEqualToString:userInfo.userId])
                {
                    continue;
                }
                [self.allFriendsArray addObject:userInfo];
            }
            
            typeof(self) __weak weakSelf = self;
            [RCIM connectWithToken:loginToken completion:^(NSString *userId) {
                [MMProgressHUD dismissWithSuccess:@"登录成功!"];
                
                HomeViewController *temp = [[HomeViewController alloc]init];
                
                [weakSelf.navigationController pushViewController:temp animated:YES];
            } error:^(RCConnectErrorCode status) {
                if(status == 0)
                {
                    [MMProgressHUD dismissWithSuccess:@"登录成功!"];
                    
                    
                    HomeViewController *temp = [[HomeViewController alloc]init];
                    
                    [weakSelf.navigationController pushViewController:temp animated:YES];
                    
                    
                }
                else
                {
                    [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"登录失败！\n Code: %d！",status]];
                }
            }];
            [RCIM setFriendsFetcherWithDelegate:self];
            [RCIM setUserInfoFetcherWithDelegate:self isCacheUserInfo:NO];
        }
        else
        {
            self.allFriendsArray = nil;
        }
        
       
    }
}

- (void)responseHttpConnectionFailed:(RCHttpRequest *)connection didFailWithError:(NSError *)error
{
    if (1000 == connection.tag) {
        [MMProgressHUD dismiss];
        [self alertTitle:@"提示" message:@"网络原因，登录失败" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
    }
    
}

-(void)requestFriendsList
{
    //获取好友列表
    NSString *url = [NSString stringWithFormat:@"%@%@",FAKE_SERVER,@"friends"];
    
    NSString* strParams = [NSString stringWithFormat:@"cookie=%@",[UserManager shareMainUser].mainUser.userEmail];
    NSLog(@"http reuqest body %@",strParams);
    self.friendRquest = [[RCHttpRequest alloc]init];
    self.friendRquest.tag = 1001;
    [self.friendRquest httpConnectionWithURL:url bodyData:[strParams dataUsingEncoding:NSUTF8StringEncoding] delegate:self];
}


#pragma mark - RCConnectFinishedDelegate
-(void)responseConnectSuccess:(NSString *)userId
{
    NSLog(@"DEMO: currerntUserId: %@",userId);
    [MMProgressHUD dismissWithSuccess:@"登录成功!"];
    
    
    HomeViewController *temp = [[HomeViewController alloc]init];
    
    [self.navigationController pushViewController:temp animated:YES];
}

-(void)responseConnectError:(RCConnectErrorCode)status
{
    if(status == 0)
    {
        [MMProgressHUD dismissWithSuccess:@"登录成功!"];
        
        
        HomeViewController *temp = [[HomeViewController alloc]init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
        
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"登录失败！\n Code: %d！",status]];
        });
    }
}

#pragma mark - RCIMFriendsFetcherDelegate method
-(NSArray *)getFriends
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.allFriendsArray];
    for (int i = array.count -1; i>=0; i--) {
        RCUserInfo *userInfo = [array objectAtIndex:i];
        NSString *userId = userInfo.userId;
        if (userId.integerValue >969 ) {
            [array removeObjectAtIndex:i];
        }
        
        
    }
    
    
    
    return array;
    //return self.allFriendsArray;
}

#pragma mark - RCIMUserInfoFetcherDelegagte method
-(RCUserInfo *)getUserInfoWithUserId:(NSString *)userId
{
    RCUserInfo *user  = nil;
    if([userId length] == 0)
        return nil;
    for(RCUserInfo *u in self.allFriendsArray)
    {
        if([u.userId isEqualToString:userId])
        {
            user = u;
            break;
        }
    }
    return user;
}
@end
