//
//  RCConversationSettingViewController.h
//  RCIM
//
//  Created by xugang on 6/16/14.
//  Copyright (c) 2014 RongCloud. All rights reserved.
//

#import "RCBasicViewController.h"
#import "RCIMClientHeader.h"
//@class RCBasicViewController;

@interface RCChatSettingViewController : RCBasicViewController{
    
    NSInteger __count;
}
@property (nonatomic,strong) UITableView *tableView;

//用于表格
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIView *HeadsPadView;
@property (nonatomic,strong) UIView *OuterHeadPadView;
@property (nonatomic,strong) NSMutableArray *iconArray;
//对方ID或者群ID
@property (nonatomic,strong) NSString *targetId;
@property (nonatomic,assign) KConversationType conversationType;

@property (nonatomic,strong)  RCDiscussionInfo* discussionInfo;

//功能列表
@property (nonatomic,strong) NSMutableArray *cellArray;


//成员信息--》废弃
@property (nonatomic,strong) NSMutableArray *memberInfos;

//讨论组IDs
@property (nonatomic,strong) NSArray *memberUserIds;

//成员数目
@property (nonatomic,assign) NSInteger  memberCount;

@property (nonatomic,assign) UILabel *discussionNameLabel;

@property (nonatomic,strong) UISwitch *TopControl;
@property (nonatomic,strong) UISwitch *messageControl;
@property (nonatomic,strong) UISwitch *inviteControl;


- (void)setNavigationTitle:(NSString *)title textColor:(UIColor*)textColor;

/**
 *  导航左面按钮点击事件
 */
-(void)leftBarButtonItemPressed:(id)sender;


@end
