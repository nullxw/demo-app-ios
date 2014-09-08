//
//  ChatSessionViewController.h
//  RongCloud
//
//  Created by Heq.Shinoda on 14-4-22.
//  Copyright (c) 2014年 Heq.Shinoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCBasicViewController.h"
#import "RCIMClientHeader.h"

typedef enum
{
    KBottomBarStatusDefault = 0,
    KBottomBarStatusKeyboard,
    KBottomBarStatusMultiAction,
    KBottomBarStatusEmoji,
    KBottomBarStatusAudio
}KBottomBarStatus;

@class MessageDataModel;

@class RCAudioRecord;
@class RCEmojiView;
@class RCConversionDataSource;
@class RCMultiActionView;
@class RCPopupMenu;
@class RCPopupMenuItem;
@class VoiceCaptureControl;
@class RCChatSessionInputBarView;
@class RCConversationTableHeaderView;


@interface RCChatViewController : RCBasicViewController
{
    KBottomBarStatus currentBottomBarStatus;
    BOOL isSendImage;
    //MessageDataModel* imageDataMessage;
    //RCAudioRecord *_myRecorder;
}
@property(nonatomic, strong)UIImagePickerController *curPicker;
@property(nonatomic, strong) RCConversionDataSource* conversionDataSource;
@property(nonatomic, strong)NSString* msgContent;
@property(nonatomic, strong) UITableView* chatListTableView;
@property (strong, nonatomic) RCChatSessionInputBarView *msgInputBar;

@property (strong, nonatomic) RCMultiActionView* multiActionView;
@property (strong, nonatomic) RCEmojiView *emojiView;

@property (strong, nonatomic) RCConversationTableHeaderView *tableHeaderView;


@property (nonatomic,assign) RCConversationType conversationType;
@property (nonatomic,strong) NSString* currentTarget;
@property (nonatomic,strong) NSString* currentTargetName;

@property (nonatomic,assign,readonly) BOOL SendingCount;
@property (nonatomic,strong) VoiceCaptureControl *voiceCaptureControl;
@property (nonatomic,strong) RCPopupMenu *popupMenu;

/**
 *  判断是否是单聊,默认NO，设置YES，会屏蔽有导航按钮
 */
@property (nonatomic ,assign) BOOL isPriavteChat;

@property (nonatomic,assign) BOOL enableViop;
-(void)reSendMessage:(NSNotification*)notification;

//发送文本消息
-(void)sendTextMessage;
-(void)drag4ResetDefaultBottomBarStatus;

- (void)setNavigationTitle:(NSString *)title textColor:(UIColor*)textColor;
/**
 *  导航左面按钮点击事件
 */
-(void)leftBarButtonItemPressed:(id)sender;
/**
 *  导航右面按钮点击事件
 */
-(void)rightBarButtonItemPressed:(id)sender;


@end
