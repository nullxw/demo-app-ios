//
//  RCIMClient.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#include "RCClientDelegate.h"

@class RCNotificationMessage;
@class RCStatusMessage;
@class RCConversation;



@interface RCIMClient : NSObject

/**
 *  获取通讯能力库的核心类单例。
 *
 *  @return 通讯能力库的核心类单例。
 */
+(RCIMClient*)sharedRCIMClient;

/**
 *  初始化 SDK。
 *
 *  @param appKey   开发者平台(<a src="http://rongcloud.cn">rongcloud.cn</>)申请的应用 Id。
 *  @param deviceToken 用于 Apple Push Notification Service 的设备唯一标识。
 */
+(void)init:(NSString*)appKey deviceToken:(NSString*)deviceToken;

/**
 *  注册消息类型，如果对消息类型进行扩展，可以忽略此方法。
 *
 *  @param objName 消息类型，必须要继承自 RCMessageContent。
 *  @param flag    如果没有找到注解时抛出。
 */
+(void)registerMessageType:(NSString*)objName flag:(int)flag;

/**
 *  连接服务器。
 *
 *  @param token    从服务端获取的用户身份令牌（Token）。
 *  @param delegate 连接的回调。
 */
+(void)connect:(NSString*)token delegate:(id<RCConnectDelegate>)delegate;

/**
 *  重新连接服务器。
 *
 *  @param delegate 连接回调。
 */
+(void)reconnect:(id<RCConnectDelegate>)delegate;

/**
 *  断开连接。
 */
-(void)disconnect;

/**
 *  获取所有未读消息数。
 *
 *  @return 未读消息数。
 */
-(int)getTotalUnreadCount;

/**
 *  获取会话列表。
 *
 *  会话列表按照时间从前往后排列，如果有置顶会话，则置顶会话在前。
 *
 *  @return 会话列表。
 */
-(NSArray*)getConversationList;

/**
 *  获取会话信息。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         会话 Id。
 *
 *  @return 会话信息。
 */
-(RCConversation*)getConversation:(KConversationType)conversationType targetId:(NSString*)targetId;

/**
 *  从会话列表中移除某一会话，但是不删除会话内的消息。如果此会话中有新的消息，该会话将重新在会话列表中显示。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         会话 Id。
 *
 *  @return 是否移除成功。
 */
-(BOOL)removeConversation:(KConversationType)conversationType targetId:(NSString*)targetId;

/**
 *  设置某一会话为置顶或者取消置顶。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *  @param isTop            是否置顶。
 *
 *  @return 是否设置成功。
 */
-(BOOL)setConversationToTop:(KConversationType)conversationType targetId:(NSString*)targetId isTop:(BOOL)isTop;

/**
 *  获取最新消息记录。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。
 *  @param count            要获取的消息数量。
 *
 *  @return 最新消息记录，按照时间顺序从旧到新排列。
 */
-(NSArray*)getLatestMessages:(KConversationType)conversationType targetId:(NSString*)targetId count:(int)count;

/**
 *  获取历史消息记录。
 *
 *  @param conversationType 会话类型。不支持传入 KConversationType.CHATROOM。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
 *  @param oldestMessageId  最后一条消息的 Id，获取此消息之前的 count 条消息。
 *  @param count            要获取的消息数量。
 *
 *  @return 历史消息记录，按照时间顺序从旧到新排列。
 */
-(NSArray*)getHistoryMessages:(KConversationType) conversationType targetId:(NSString*)targetId oldestMessageId:(long)oldestMessageId count:(int)count;

/**
 *  删除指定的一条或者一组消息。
 *
 *  @param idList 要删除的消息 Id 列表。
 */
-(void)deleteMessages:(NSArray*)idList;

/**
 *  清空某一会话的所有聊天消息记录。
 *
 *  @param conversationType 会话类型。不支持传入 KConversationType.CHATROOM。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
 *
 *  @return 是否清空成功。
 */
-(BOOL)clearMessages:(KConversationType)conversationType targetId:(NSString*)targetId;


/**
 *  清除消息未读状态。
 *
 *  @param conversationType 会话类型。不支持传入 KConversationType.CHATROOM。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
 *
 *  @return 是否清空成功。
 */
-(BOOL)clearMessagesUnreadStatus:(KConversationType)conversationType targetId:(NSString*)targetId;

/**
 *  设置消息的附加信息，此信息只保存在本地。
 *
 *  @param messageId 消息 Id。
 *  @param value     消息附加信息，最大 1024 字节。
 *
 *  @return 是否设置成功。
 */
-(BOOL)setMessageExtra:(long)messageId value:(NSString*)value;

/**
 *  保存文字消息草稿。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *  @param content          草稿的文字内容。
 *
 *  @return 是否保存成功。
 */
-(BOOL)saveTextMessageDraft:(KConversationType)conversationType targetId:(NSString*)targetId content:(NSString*)content;

/**
 *  获取某一会话的文字消息草稿。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *
 *  @return 草稿的文字内容。
 */
-(NSString*)getTextMessageDraft:(KConversationType)conversationType targetId:(NSString*)targetId;

/**
 *  清除某一会话的文字消息草稿。
 *
 *  @param conversationType 会话类型。
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *
 *  @return 是否清除成功。
 */
-(BOOL)clearTextMessageDraft:(KConversationType)conversationType targetId:(NSString*)targetId;

/**
 *  获取讨论组信息和设置。
 *
 *  @param discussionId 讨论组 Id。
 *  @param delegate     获取讨论组的回调。
 *  @param userData     用户自定义数据，该值会在 delegate 中返回。
 */
-(void)getDiscussion:(NSString*)discussionId conversationType:(KConversationType)conversationType delegate:(id<RCGetDiscussionDelegate>)delegate object:(id)userData;
-(void)getDiscussion:(NSString*)discussionId conversationType:(KConversationType)conversationType completion:(void (^)(RCDiscussionInfo* dInfo))completion error:(void (^)(KErrorCode status))error;

/**
 *  创建讨论组。
 *
 *  @param name       讨论组名称，如：当前所有成员的名字的组合。
 *  @param userIdList 讨论组成员 Id 列表。
 *  @param delegate   创建讨论组成功后的回调。
 *  @param userData   用户自定义数据，该值会在 delegate 中返回。
 */
-(void)createDiscussion:(NSString*)name userIdList:(NSArray*)userIdList delegate:(id<RCCreateDiscussionDelegate>)delegate object:(id)userData;
-(void)createDiscussion:(NSString *)name userIdList:(NSArray *)userIdList completion:(void (^)(RCDiscussionInfo* discussInfo))completion error:(void (^)(KErrorCode status))error;

/**
 *  邀请一名或者一组用户加入讨论组。
 *
 *  @param discussionId 讨论组 Id。
 *  @param userIdList   邀请的用户 Id 列表。
 *  @param delegate     执行操作的回调。
 *  @param userData     用户自定义数据，该值会在 delegate 中返回。
 */
-(void)inviteMemberToDiscussion:(NSString*)discussionId userIdList:(NSArray*)userIdList delegate:(id<RCOperationDelegate>)delegate object:(id)userData;
-(void)inviteMemberToDiscussion:(NSString*)discussionId userIdList:(NSArray*)userIdList completion:(void (^)(KErrorCode status))completion;

/**
 *  供创建者将某用户移出讨论组。
 *
 *  移出自己或者调用者非讨论组创建者将产生 {@link io.rong.imlib.RongIMClient.OperationCallback.ErrorCode#UNKNOWN} 错误。 // TODO: 转化成对应的类型。
 *
 *  @param discussionId 讨论组 Id。
 *  @param userId       用户 Id。
 *  @param delegate     执行操作的回调。
 *  @param userData     用户自定义数据，该值会在 delegate 中返回。
 */
-(void)removeMemberFromDiscussion:(NSString*)discussionId userId:(NSString*)userId delegate:(id<RCOperationDelegate>)delegate object:(id)userData;
-(void)removeMemberFromDiscussion:(NSString*)discussionId userId:(NSString*)userId completion:(void (^)(KErrorCode status))completion;

/**
 *  退出当前用户所在的某讨论组。
 *
 *  @param discussionId 讨论组 Id。
 *  @param delegate     执行操作的回调。
 *  @param userData     用户自定义数据，该值会在 delegate 中返回。
 */
-(void)quitDiscussion:(NSString*)discussionId delegate:(id<RCOperationDelegate>)delegate object:(id)userData;
-(void)quitDiscussion:(NSString*)discussionId completion:(void (^)(KErrorCode status))completion;

/**
 *  发送消息。
 *
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id 或聊天室 Id。
 *  @param conversationType 会话类型。
 *  @param content          消息内容。
 *  @param delegate         发送消息的回调。
 *  @param userData         用户自定义数据，该值会在 delegate 中返回。
 *
 *  @return 发送的消息实体。
 */
-(RCMessage*)sendMessage:(NSString*)targetId conversationType:(KConversationType)conversationType content:(RCMessageContent*)content delegate:(id<RCSendMessageDelegate>)delegate object:(id)userData;
-(RCMessage*)sendMessage:(NSString*)targetId conversationType:(KConversationType)conversationType content:(RCMessageContent*)content completion:(void (^)(KErrorCode status, long messageId))completion progress:(void (^)(int iProgress, long messageId))progress error:(void (^)(int nErrorCode, long messageId))error;

/**
 *  发送通知消息。
 *
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
 *  @param conversationType 会话类型。
 *  @param content          通知消息内容。
 *  @param delegate         发送通知消息的回调。
 *  @param userData         用户自定义数据，该值会在 delegate 中返回。
 *
 *  @return 发送的通知消息实体。
 */
-(RCMessage*)sendNotification:(NSString*)targetId conversationType:(KConversationType)conversationType content:(RCNotificationMessage*)content delegate:(id<RCSendMessageDelegate>)delegate object:(id)userData;

/**
 *  发送状态消息。
 *
 *  此类消息不保证必达，但是速度最快，所以通常用来传递状态信息。如：发送对方正在输入的状态。
 *
 *  @param targetId         目标 Id。根据不同的 conversationType，可能是聊天 Id、讨论组 Id、群组 Id。
 *  @param conversationType 会话类型。
 *  @param content          状态消息的内容。
 *  @param delegate         发送状态消息的回调。
 *  @param userData         用户自定义数据，该值会在 delegate 中返回。
 *
 *  @return 发送的状态消息实体。
 */
-(RCMessage*)sendStatus:(NSString*)targetId conversationType:(KConversationType)conversationType content:(RCStatusMessage*)content delegate:(id<RCSendMessageDelegate>)delegate object:(id)userData;

/**
 *  下载媒体文件。
 *
 *  @param msgObj   // TODO: 为什么不是消息 Id。
 *  @param delegate 下载媒体文件的回调。
 *  @param userData 用户自定义数据，该值会在 delegate 中返回。
 */
-(void)downloadMedia:(KConversationType)conversationType targetId:(NSString*)targetId  mediaType:(KMediaType)mediaType key:(NSString*)key delegate:(id<RCDownloadMediaDelegate>)delegate object:(id)userData;

/**
 *  获取用户信息。
 *
 *  如果本地缓存中包含用户信息，则从本地缓存中直接获取，否则将访问融云服务器获取用户登录时注册的信息；<br/>
 *  但如果该用户如果从来没有登录过融云服务器，返回的用户信息会为空值。
 *
 *  @param userId   用户 Id。
 *  @param delegate 获取用户信息的回调。
 *  @param userData 用户自定义数据，该值会在 delegate 中返回。
 */
-(void)getUserInfo:(NSString*)userId delegate:(id<RCGetUserInfoDelegate>)delegate object:(id)userData;
-(void)getUserInfo:(NSString*)userId completion:(void (^)(RCUserInfo* user))completion;

/**
 *  设置接收消息的监听器。
 *
 *  所有接收到的消息、通知、状态都经由此处设置的监听器处理。包括私聊消息、讨论组消息、群组消息、聊天室消息以及各种状态。
 *
 *  @param delegate 接收消息的监听器。
 *  @param userData 用户自定义数据，该值会在 delegate 中返回。
 */
-(void)setReceiveMessageListener:(id<RCReceiveMessageDelegate>)delegate object:(id)userData;

/**
 *  设置连接状态变化的监听器。
 *
 *  @param delegate 连接状态变化的监听器。
 */
-(void)setConnectionStatusDelegate:(id<RCConnectionStatusDelegate>)delegate;

/**
 *  设置接收到的消息状态。
 *
 *  @param messageId     消息 Id。
 *  @param receiveStatus 消息的状态。
 */
-(void)setReceiveStatus:(long)messageId receiveStatus:(KReceivedStatus)receiveStatus;
/**
 *  群聊更名
 *
 *  @param targitId
 *  @param conversationType
 *  @param discussionName
 *  @param completion
 */
-(void)renameDiscussion:(NSString*)targitId conversationType:(KConversationType)conversationType name:(NSString*)discussionName completion:(void (^)(KErrorCode status))completion;

/**
 *  设置开放成员邀请
 *
 *  @param isOpen
 *  @param targitId
 *  @param conversationType
 *  @param completion
 */
-(void)setInviteStatus:(BOOL)isOpen  targetId:(NSString*)targitId conversationType:(KConversationType)conversationType completion:(void (^)(KErrorCode status))completion;

/**
 *  设置新消息通知
 *
 *  @param targetId
 *  @param conversationType
 *  @param completion
 */
-(void)setConversationPushNotification:(BOOL)isRecv targetId:(NSString*)targetId conversationType:(KConversationType)conversationType completion:(void (^)(KErrorCode status, KBizAckStatus bizStatus))completion;

/**
 *  获取新消息通知状态
 *
 *  @param targetId
 *  @param conversationType
 *  @param completion
 */
-(void)getConversationPushNotification:(NSString*)targetId conversationType:(KConversationType)conversationType completion:(void (^)(KErrorCode status, KBizAckStatus bizStatus))completion;

/**
 *  获取用户未读消息数
 *
 *  @param targetId
 *  @param conversationType
 */
-(int)getUnreadCountWithUserId:(NSString*)targetId conversationType:(KConversationType)conversationType;

/**
 *  获取当前组件的版本号。
 *
 *  @return 当前组件的版本号。
 */
+(NSString*)getLibraryVersion;

@end
