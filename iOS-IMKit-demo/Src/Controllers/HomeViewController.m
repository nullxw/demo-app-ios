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
#import "DemoChatListViewController.h"
#import "DemoChatViewController.h"
#import "RCHandShakeMessage.h"
#import "RCGroup.h"
#import "DemoCommonConfig.h"

@interface HomeViewController ()<RCIMConnectionStatusDelegate,RCIMGroupInfoFetcherDelegate>

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.groupList = [[NSMutableArray alloc]init];
        
        RCGroup *group001 = [[RCGroup alloc]init];
        group001.groupId = @"group001";
        group001.groupName =@"群组一";
        [_groupList addObject:group001];
        
        RCGroup *group002 = [[RCGroup alloc]init];
        group002.groupId = @"group002";
        group002.groupName =@"群组二";
        [_groupList addObject:group002];
        
        RCGroup *group003 = [[RCGroup alloc]init];
        group003.groupId = @"group003";
        group003.groupName =@"群组三";
        [_groupList addObject:group003];
        
        [[RCIMClient sharedRCIMClient]syncGroups:_groupList completion:^{
            
        } error:^(RCErrorCode status) {
            NSLog(@"同步群数据status%d",status);
        }];
        
        
        
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
    
     NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"默认",@"自定义",nil];
    self.segment = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = [UIColor whiteColor];
    self.navigationItem.titleView  = self.segment;
    
    
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
    [RCIM setGroupInfoFetcherWithDelegate:self];
    
    
    
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.hidden =NO;
    
    self.dataList = [NSMutableArray array];
    
    for (int i=0; i<7; i++) {
        
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
        
        if (3 ==i) {
            cell.textLabel.text = @"启动群组一";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (4 ==i) {
            cell.textLabel.text = @"启动群组二";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (5 ==i) {
            cell.textLabel.text = @"启动群组三";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (6 == i) {
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
    
    
    [[RCIM sharedRCIM]setConnectionStatusDelegate:self];

    
    //self.navigationItem.title = @"DEMO";
   // self.navigationItem.leftBarButtonItem = nil;
}

-(void)responseConnectionStatus:(RCConnectionStatus)status{
    if (ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT == status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"" message:@"您已下线，重新连接？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
            alert.tag = 2000;
            [alert show];
        });
        
        
    }
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
    
    if (0 == self.segment.selectedSegmentIndex) {
        
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
            
            //线上
            //[[RCIM sharedRCIM]launchCustomerServiceChat:self customerServiceUserId:@"kefu114" title:@"客服" completion:NULL];
            
            //测试
            [[RCIM sharedRCIM]launchCustomerServiceChat:self customerServiceUserId:@"kefu114" title:@"客服" completion:NULL];
        }
        
        if (3 == indexPath.row) {
            
            RCGroup *group = [_groupList objectAtIndex:0];
            
            RCChatViewController *temp = [[RCChatViewController alloc]init];
            temp.currentTarget = group.groupId;
            temp.conversationType = ConversationType_GROUP;
            temp.currentTargetName = group.groupName;
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        
        if (4 == indexPath.row) {
            
            RCGroup *group = [_groupList objectAtIndex:1];
            
            RCChatViewController *temp = [[RCChatViewController alloc]init];
            temp.currentTarget = group.groupId;
            temp.conversationType = ConversationType_GROUP;
            temp.currentTargetName = group.groupName;
            [self.navigationController pushViewController:temp animated:YES];
        }
        
        if (5 == indexPath.row) {
            
            RCGroup *group = [_groupList objectAtIndex:2];
            
            RCChatViewController *temp = [[RCChatViewController alloc]init];
            temp.currentTarget = group.groupId;
            temp.conversationType = ConversationType_GROUP;
            temp.currentTargetName = group.groupName;
            [self.navigationController pushViewController:temp animated:YES];
        }
        
        //注销
        if (6 == indexPath.row) {
            [[RCIM sharedRCIM] disconnect];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    
    //自定义模式
    if (1 == self.segment.selectedSegmentIndex) {
        
        if (0==indexPath.row) {
            
            DemoChatListViewController *temp = [[DemoChatListViewController alloc]init];
            
            [self.navigationController pushViewController:temp animated:YES];
            temp.portraitStyle = UIPortraitViewRound;
            
            //[[RCIM sharedRCIM] launchConversationList:self];
        }
        
        
        
        //启动单聊
        if (1 == indexPath.row) {
            
            DemoChatViewController *temp = [[DemoChatViewController alloc]init];
            
            temp.currentTarget = [UserManager shareMainUser ].mainUser.userId;
            temp.conversationType = ConversationType_PRIVATE;
            temp.currentTargetName = @"单聊";
            temp.enableSetting = NO;
            temp.portraitStyle = UIPortraitViewRound;
            
            [self.navigationController pushViewController:temp animated:YES];
        }
        //启动客户
        if (2 == indexPath.row) {
            NSString *customerServiceUserId = @"kefu114";
            //线上
            //[[RCIM sharedRCIM]launchCustomerServiceChat:self customerServiceUserId:@"kefu114" title:@"客服" completion:NULL];
            
            //测试
            //[[RCIM sharedRCIM]launchCustomerServiceChat:self customerServiceUserId:customerServiceUserId title:@"客服" completion:NULL];
            
            
            DemoChatViewController *temp = [[DemoChatViewController alloc]init];
            
            temp.currentTarget = @"kefu114";
            temp.conversationType = ConversationType_PRIVATE;
            temp.currentTargetName = @"客服";
            temp.enableSetting = NO;
            temp.enableViop = NO;
            RCHandShakeMessage* textMsg = [[RCHandShakeMessage alloc] initWithType:1];
            [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:customerServiceUserId content:textMsg delegate:nil];
            
            [self.navigationController pushViewController:temp animated:YES];
            
            
        }
        
        //注销
        if (6 == indexPath.row) {
            [[RCIM sharedRCIM] disconnect];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (2000 == alertView.tag) {
        
        if (0 == buttonIndex) {
            
            NSLog(@"NO");
        }
        
        if (1 == buttonIndex) {
            
            NSLog(@"YES");
            
            [RCIMClient reconnect:nil];
        }
    }
    
}


#pragma mark - RCIMGroupInfoFetcherDelegate method
-(RCGroup*)getGroupInfoWithGroupId:(NSString*)groupId
{
    RCGroup *group  = nil;
    if([groupId length] == 0)
        return nil;
    for(RCGroup *__g in self.groupList)
    {
        if([__g.groupId isEqualToString:groupId])
        {
            group = __g;
            break;
        }
    }
    return group;
}

@end
