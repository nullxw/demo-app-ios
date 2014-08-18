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

//异常状态监听
@protocol RCConnectionStatusDelegate <NSObject>
-(void)receivedExpcetionStatus:(KExceptionStatus)status desc:(NSString*)description;
@end



//App网络连接状态
@protocol RCEnvChangeNotifyDelegate <NSObject>
-(void)responseEnvChangedNotify:(KAppCurrentEnvironment)environmentType attachment:(NSString*)attachment;
@end

//发送消息返回.
@protocol RCSendMessageDelegate <NSObject>
- (void)responseSendMessageStatus:(KMessageSentStatus)status messageId:(long)messageId object:(id)object;
@optional
-(void)responseUploadFileProgress:(int)iProgress messageId:(long)messageId object:(id)object;//发送（如：图片或视频）文件返回进度状态。
-(void)responseUploadFileError:(int)nErrorCode messageId:(long)messageId object:(id)object;//发送（如：图片或视频）文件返回错误处理。
@end

//创建讨论组
@protocol RCCreateDiscussionDelegate <NSObject>
- (void)responseCreateDiscussionSuccess:(NSString*)discussionId discussionName:(NSString*)discussionName userIdList:(NSArray*)userIdList object:(id)object;
- (void)responseCreateDiscussionError:(KDiscussionStatus)status;
@end

//讨论组：邀请、移除、退出
@protocol RCOperationDelegate <NSObject>
- (void)responseOperateDiscussionStatus:(KDiscussionStatus)status discussionId:(NSString*)discussionId memberIds:(NSArray*)memberIds removedUserId:(NSString*)removedUserId object:(id)object;
@end

//设置接收消息返回监听.
@protocol RCReceiveMessageDelegate <NSObject>
-(void)responseOnReceived:(RCMessage*)message object:(id)object;
@end

////发送文件回调
//@protocol RCUploadFileDelegate <NSObject>
//-(void)responseUploadFileProgress:(int)iProgress userInfo:(NSDictionary*)userInfo;//发送（如：图片或视频）文件返回进度状态。
//-(void)responseUploadFileError:(int)nErrorCode ErrDescription:(NSString*)strDescription type:(int)type userInfo:(NSDictionary*)userInfo;//发送（如：图片或视频）文件返回错误处理。
//@end

//下载文件回调
@protocol RCDownloadMediaDelegate <NSObject>
//-(void)responseDownloadFile:(NSData*)dataFromDown;
-(void)responseFileDownloadProgress:(int)iProgress object:(id)object;//接收（如：图片或视频）文件返回进度状态。
-(void)responseFileDownloadFinished:(int)nErrorCode imagePath:(NSString*)imagePath object:(id)object;//发送（如：图片或视频）文件返回错误处理。
@end

//获取用户信息
@protocol RCGetUserInfoDelegate<NSObject>
//-获取用户信息返回函数。
-(void)responseGetUserInfo:(RCUserInfo*)userInfo;
@end

//获取讨论组信息
@protocol RCGetDiscussionDelegate<NSObject>
//-获取用户信息返回函数。
-(void)responseDiscussionInfo:(RCDiscussionInfo*)discussionInfo object:(id)object;
@end







