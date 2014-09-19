//
//  DemoChatsettingViewController.m
//  iOS-IMKit-demo
//
//  Created by xugang on 8/30/14.
//  Copyright (c) 2014 Heq.Shinoda. All rights reserved.
//

#import "DemoChatsettingViewController.h"
#import "DemoRenameController.h"

@implementation DemoChatsettingViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    //自定义导航标题颜色
    [self setNavigationTitle:@"设置" textColor:[UIColor whiteColor]];
    
    //自定义导航左右按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonItemPressed:)];
    [leftButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)leftBarButtonItemPressed:(id)sender
{
    [super leftBarButtonItemPressed:sender];
}

-(void)renameDiscussionName:(RCConversationType)conversationType targetId:(NSString*)targetId oldName:(NSString*)oldName{
    
    RCRenameViewController *temp = [[RCRenameViewController alloc]init];
    temp.delegate = self;
    temp.targetId = targetId;
    temp.oldName = oldName;
    temp.conversationType =conversationType;
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:temp];
    
    //导航和原有的配色保持一直
    UIImage *image= [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    
    [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:nav animated:YES completion:NULL];
}
@end
