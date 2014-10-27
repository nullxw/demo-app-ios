//
//  RCMessageContent.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCStatusDefine.h"

/*!
    \protocol RCMessageCoding
 */
@protocol RCMessageCoding <NSObject>
@required
- (NSData *)encode;
- (void)decodeWithData:(NSData *)data;
+ (NSString *)getObjectName;
@end

/*!
    \protocol RCMessagePersistentCompatible
     
    \note The base class RCMessageContent has already conformed to this protocol.
 */
@protocol RCMessagePersistentCompatible <NSObject>
@required
/*!
    \brief
    The base class RCMessageContent has implemented this method, The default return value is
    \constant (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED)
    aka. the value is equal to 0x11
 */
+(RCMessagePersistent)persistentFlag;
@end

@interface RCMessageContent : NSObject <RCMessageCoding, RCMessagePersistentCompatible>
{
 @private
    NSString *_targetId;
}
@property(nonatomic, strong, setter=setRawJSONData:)NSData *rawJSONData;

@end
