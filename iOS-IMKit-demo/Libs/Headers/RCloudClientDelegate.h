//
//  RCloudClientDelegate.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-12.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCMessage.h"
#import "RCUserInfo.h"
#import "RCConnectStatusDefination.h"

@class RCDiscussionInfo;
//----API listener point to delegate--//
//帐户连接Server返回。
@protocol RCConnectDelegate <NSObject>
- (void)responseConnectSuccess:(NSString*)userId;
- (void)responseConnectError:(KConnectErrorCode)status;
@end

//App网络连接状态
@protocol RCConnectionStatusDelegate <NSObject>
-(void)receivedConnectionStatus:(KConnectionStatus)status desc:(NSString*)description;
@end

//发送消息返回.
@protocol RCSendMessageDelegate <NSObject>
- (void)responseSendMessageStatus:(KErrorCode)status messageId:(long)messageId object:(id)object;
@optional
-(void)responseProgress:(int)iProgress messageId:(long)messageId object:(id)object;//发送（如：图片或视频）文件返回进度状态。
-(void)responseError:(int)nErrorCode messageId:(long)messageId object:(id)object;//发送（如：图片或视频）文件返回错误处理。
@end

//创建讨论组
@protocol RCCreateDiscussionDelegate <NSObject>
- (void)responseCreateDiscussionSuccess:(NSString*)discussionId discussionName:(NSString*)discussionName userIdList:(NSArray*)userIdList object:(id)object;
- (void)responseCreateDiscussionError:(KErrorCode)status;
@end

//讨论组：邀请、移除、退出
@protocol RCOperationDelegate <NSObject>
- (void)responseOperateSuccess:(id)object;
- (void)responseOperateError:(KErrorCode)status object:(id)object;
@end

//设置接收消息返回监听.
@protocol RCReceiveMessageDelegate <NSObject>
-(void)responseOnReceived:(RCMessage*)message object:(id)object;
@end


//下载文件回调
@protocol RCDownloadMediaDelegate <NSObject>
-(void)responseProgress:(int)iProgress object:(id)object;//接收（如：图片或视频）文件返回进度状态。
-(void)responseSuccess:(NSString*)localMediaPath;//成功（如：图片或视频）文件返回进度状态。
-(void)responseError:(int)nErrorCode object:(id)object;//发送（如：图片或视频）文件返回错误处理。
@end

//获取用户信息
@protocol RCGetUserInfoDelegate<NSObject>
//-获取用户信息返回函数。
-(void)responseGetUserInfoSuccess:(RCUserInfo*)userInfo;
-(void)responseGetUserInfoError:(KErrorCode)status;
@end

//获取讨论组信息
@protocol RCGetDiscussionDelegate<NSObject>
//-获取用户信息返回函数。
-(void)responseDiscussionInfoSuccess:(RCDiscussionInfo*)discussionInfo object:(id)object;
-(void)responseDiscussionInfoError:(KErrorCode)status object:(id)object;
@end








