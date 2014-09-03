//
//  RCIM.h
//  RCIM
//  ios -IMKit Version 0.9.1005.0900
//  Created by Heq.Shinoda on 14-5-27.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RCClientDelegate.h"
#import "RCUserInfo.h"


/**
 *  用户信息的获取器。
 *
 *  如果在聊天中遇到的聊天对象是没有登录过的用户（即没有通过融云服务器鉴权过的），RongIM 是不知道用户信息的，RongIM 将调用此 Delegagte 获取用户信息。
 */
@protocol RCIMUserInfoFetcherDelegagte <NSObject>

/**
 *  获取用户信息。
 *
 *  @param userId 用户 Id。
 *
 *  @return 用户信息。
 */
-(RCUserInfo*)getUserInfoWithUserId:(NSString*)userId;
@end

/**
 *  好友列表的获取器。
 *
 *  RongIM 本身不保存 App 的好友关系，如果在聊天中需要使用好友关系时（如：需要选择好友加入群聊），RongIM 将调用此 Delegagte 获取好友列表信息。
 */
@protocol RCIMFriendsFetcherDelegate <NSObject>

/**
 *  获取好友信息列表。
 *
 *  @return 好友信息列表。
 */
-(NSArray*)getFriends;
@end

/**
 *  接收消息的监听器。
 */
@protocol RCIMReceiveMessageDelegate <NSObject>

/**
 *  接收消息到消息后执行。
 *
 *  @param message 接收到的消息。
 */
-(void)didReceivedMessage:(RCMessage*)message;
@end

/**
 *  IM 界面组件核心类。
 *
 *  所有 IM 相关界面、功能都由此调用和设置。
 */
@interface RCIM : NSObject

/**
 *  获取界面组件的核心类单例。
 *
 *  @return 界面组件的核心类单例。
 */
+(RCIM*)sharedRCIM;

/**
 *  初始化 SDK。
 *
 *  @param appKey   从开发者平台申请的应用 appKey。
 *  @param deviceToken 用于 Apple Push Notification Service 的设备唯一标识。
 */
+(void)initWithAppKey:(NSString*)appKey deviceToken:(NSString*)deviceToken;

/**
 *  IM 界面组件登录。
 *
 *  @param token    从服务端获取的用户身份令牌（Token）</a>。
 *  @param delegate 登录回调。
 */
+(void)connectWithToken:(NSString*)token completion:(void (^)(NSString* userId))completion error:(void (^)(KConnectErrorCode status))error;

/**
 *  设置获取好友列表的获取器，供 RongIM 调用获取好友列表以及好友的名称和头像信息。
 *
 *  @param delegate 获取好友列表的获取器。
 */
+(void)setFriendsFetcherWithDelegate:(id<RCIMFriendsFetcherDelegate>)delegate;

/**
 *  设置获取用户信息的获取器，供 RongIM 调用获取用户名称和头像信息。
 *
 *  @param delegate        获取用户信息获取器。
 *  @param isCacheUserInfo 设置是否由 IMKit 来缓存用户信息。<br/>
 *            如果 App 提供的 RCIMUserInfoFetcherDelegagte 每次都需要通过网络请求用户数据，而不是将用户数据缓存到本地，会影响用户信息的加载速度；<br/>
 *            此时最好将本参数设置为 true，由 IMKit 来缓存用户信息。
 */
+(void)setUserInfoFetcherWithDelegate:(id<RCIMUserInfoFetcherDelegagte>)delegate isCacheUserInfo:(BOOL)isCacheUserInfo;

/**
 *  创建会话列表界面，供应用程序使用。
 *
 *  @return return 会话列表的视图控制器。
 *
 *  @param completion completion handler
 */
-(UIViewController*)createConversationList:(void(^)(void))completion;

/**
 *  启动会话列表界面。
 *
 *  @param viewController 会话列表的视图控制器。
 *
 *  @param completion completion handler
 */
-(void)launchConversationList:(UIViewController*)viewController completion:(void(^)(void))completion;

/**
 *  创建单聊界面，供应用程序使用。
 *
 *  @param targetUserId 要与之聊天的用户 Id。
 *  @param title        聊天的标题，如果传入空值，则默认显示与之聊天的用户名称。
 *
 *  @return 单聊的视图控制器。
 *
 *  @param completion completion handler
 */
-(UIViewController*)createPrivateChat:(NSString*)targetUserId title:(NSString*)title completion:(void(^)(void))completion;

/**
 *  启动单聊界面。
 *
 *  @param viewController 单聊的视图控制器。
 *  @param targetUserId   要与之聊天的用户 Id。
 *  @param title          聊天的标题，如果传入空值，则默认显示与之聊天的用户名称。
 *
 *  @param completion completion handler
 */
-(void)launchPrivateChat:(UIViewController*)viewController targetUserId:(NSString*)targetUserId title:(NSString*)title completion:(void(^)(void))completion;

/**
 *  创建客户服聊天界面。
 *
 *  @param customerServiceUserId   要与之聊天的客服 Id。
 *  @param title          聊天的标题，如果传入空值，则默认显示与之聊天的客服名称。
 *
 *  @param completion completion handler
 */
-(UIViewController*)createCustomerService:(NSString *)customerServiceUserId title:(NSString *)title completion:(void(^)(void))completion;

/**
 *  启动客户服聊天界面。
 *
 *  @param viewController 客服聊天的视图控制器。
 *  @param customerServiceUserId   要与之聊天的客服 Id。
 *  @param title          聊天的标题，如果传入空值，则默认显示与之聊天的客服名称。
 *
 *  @param completion completion handler
 */
-(void)launchCustomerServiceChat:(UIViewController*)viewController customerServiceUserId:(NSString*)customerServiceUserId title:(NSString*)title completion:(void(^)(void))completion;

/**
 *  设置接收消息的监听器。
 *
 *  所有接收到的消息、通知、状态都经由此处设置的监听器处理。包括单聊消息、讨论组消息、群组消息、聊天室消息以及各种状态。<br/>
 *  此处仅为扩展功能提供，默认可以不做实现。
 *
 *  @param delegate 接收消息的监听器。
 */
-(void)setReceiveMessageDelegate:(id<RCIMReceiveMessageDelegate>)delegate;

/**
 *  以当前用户的身份发送一条消息。
 *  
 *  此处仅为扩展功能提供，默认可以不做实现。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *  @param content          消息内容。
 *  @param delegate         发送消息的回调。
 *
 *  @return 发送的消息实体。
 */
-(RCMessage*)sendMessageWithConversationType:(KConversationType)conversationType targetId:(NSString*)targetId content:(RCMessageContent*)content delegate:(id<RCSendMessageDelegate>)delegate;

/**
 *  注销当前登录。
 */
-(void)disconnect;

/**
 *  获取会话列表
 *
 *  @return 返回会话RCConversation数组
 */
-(NSArray*)getConversationList;


/**
 *  获取所有未读消息数。
 *
 *  @return 未读消息数。
 */
-(int)getTotalUnreadCount;

/**
 *  获取用户未读消息数
 *
 *  @param targetId     目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *  @param conversationType 会话类型。
 */
-(int)getUnreadCountWithUserId:(NSString*)targetId conversationType:(KConversationType)conversationType;

/**
 *  设置用户头像点击事件
 *
 *  @param viewController    点击事件当前的viewController
 *  @param userInfo          用户信息
 */
-(void)setUserPortraitClickEvent:(void(^)(UIViewController *viewController, RCUserInfo *userInfo)) clickEvent;

/**
 *  获取当前组件的版本号。
 *
 *  @return 当前组件的版本号。
 */
+(NSString*)getLibraryVersion;
@end
