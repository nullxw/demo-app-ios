//
//  HomeViewController.m
//  iOS-IMKit-demo
//
//  Created by xugang on 7/24/14.
//  Copyright (c) 2014 Heq.Shinoda. All rights reserved.
//

#import "HomeViewController.h"
#import "UserDataModel.h"
#import "UserInfoViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    //[aView release];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    
    [[RCIM sharedRCIM] setUserPortraitClickEvent:^(UIViewController *viewController, RCUserInfo *userInfo) {
        NSLog(@"%@,%@",viewController,userInfo);
        
        UserInfoViewController *temp = [[UserInfoViewController alloc]init];
        temp.nameLabel.text = userInfo.name;
        
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:temp];
        
        //导航和的配色保持一直
        UIImage *image= [viewController.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        //[nav.navigationBar setBackgroundImage:self.navigationController.navigationBar. forBarMetrics:UIBarMetricsDefault];
        
        
        [viewController presentViewController:nav animated:YES completion:NULL];
        
    }];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.hidden =NO;
    
    self.dataList = [NSMutableArray array];
    
    for (int i=0; i<4; i++) {
        
        UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        if (0==i) {
            cell.textLabel.text = @"启动会话列表";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (1==i) {
            cell.textLabel.text = @"启动单聊";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (2==i) {
            cell.textLabel.text = @"启动客服";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (3==i) {
            cell.textLabel.text = @"注销";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        [self.dataList addObject:cell];
        
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style: UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizesSubviews  = YES;
    self.tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    self.tableView.rowHeight = 65;
    
    
    [self.view addSubview:self.tableView];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    self.navigationItem.title = @"DEMO";
   // self.navigationItem.leftBarButtonItem = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.dataList objectAtIndex:indexPath.row];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //+(void)initWithAppKey:(NSString*)appKey deviceToken:(NSString*)deviceToken;
    //+(void)connectWithToken:(NSString*)token delegate:(id<RCConnectDelegate>)delegate;
    
    //启动会话列表
    
    if (0==indexPath.row) {
        UIViewController *temp = [[RCIM sharedRCIM]createConversationList:NULL];
        [self.navigationController pushViewController:temp animated:YES];
        
        //[[RCIM sharedRCIM] launchConversationList:self];
    }
    
    
    
    //启动单聊
    if (1 == indexPath.row) {
        
        UIViewController * temp= [[RCIM sharedRCIM]createPrivateChat:[UserManager shareMainUser ].mainUser.userId title:@"单聊" completion:NULL];
        [self.navigationController pushViewController:temp animated:YES];
    }
    //启动客户
    if (2 == indexPath.row) {
        [[RCIM sharedRCIM]launchCustomerServiceChat:self customerServiceUserId:@"kefu114" title:@"客服" completion:NULL];
    }
    
    //注销
    if (3 == indexPath.row) {
        [[RCIM sharedRCIM] disconnect];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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

@end
