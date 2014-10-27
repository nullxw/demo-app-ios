//
//  RCDiscussionNotification.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-26.
//  Copyright (c) 2014年 Heq.Shinoda. All rights reserved.
//

#import "RCNotificationMessage.h"
/*!
    \enum RCDiscussionNotificationType
    \constant RCJoinDiscussionNotification   
        Join to the current discussion
    \constant RCQuitDiscussionNotification 
        Quit from the discussion
    \constant RCRenameDiscussionTitleNotification 
        Change discussion title
    \constant RCRemoveDiscussionMemberNotification 
        Expel member
 */

typedef NS_ENUM(NSInteger, RCDiscussionNotificationType) {
    RCInviteDiscussionNotification = 1,       //
    RCQuitDiscussionNotification,           //
    RCRenameDiscussionTitleNotification,    //
    RCRemoveDiscussionMemberNotification,    //
    RCSwichInvitationAccessNotification,
};

@interface RCDiscussionNotification : RCNotificationMessage
@property(nonatomic, assign) NSInteger type;
@property(nonatomic, strong) NSString *operatorId;
@property(nonatomic, strong) NSString *extension;

+(instancetype)notificationWithType:(RCDiscussionNotificationType )type
                           operator:(NSString *)operatorId
                          extension:(NSString *)extension;
@end
