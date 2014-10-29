//
//  DemoGroupViewController.m
//  iOS-IMKit-demo
//
//  Created by xugang on 9/7/14.
//  Copyright (c) 2014 Heq.Shinoda. All rights reserved.
//

#import "DemoGroupListViewController.h"
#import "DemoChatViewController.h"

@interface DemoGroupListViewController ()

@end

@implementation DemoGroupListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义导航标题颜色
    [self setNavigationTitle:@"会话" textColor:[UIColor whiteColor]];
    
    //自定义导航左右按钮
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonItemPressed:)];
    [leftButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)leftBarButtonItemPressed:(id)sender
{
    [super leftBarButtonItemPressed:sender];
}

/**
 *  重载选择表格事件
 *
 *  @param conversation <#conversation description#>
 */
-(void)onSelectedTableRow:(RCConversation*)conversation{
    
    DemoChatViewController* chat = [self getChatController:conversation.targetId conversationType:conversation.conversationType];
    if (nil == chat) {
        chat =[[DemoChatViewController alloc]init];
        chat.portraitStyle = RCUserAvatarCycle;
        [self addChatController:chat];
    }
    
    chat.currentTarget = conversation.targetId;
    chat.conversationType = conversation.conversationType;
    //chat.currentTargetName = curCell.userNameLabel.text;
    chat.currentTargetName = conversation.conversationTitle;
    [self.navigationController pushViewController:chat animated:YES];
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

@end
