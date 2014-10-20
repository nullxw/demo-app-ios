//
//  RCTextMessage.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"

@interface RCTextMessage : RCMessageContent //<RCMessageCoding, RCMessagePersistentCompatible>
@property(nonatomic, strong) NSString* content;

+(instancetype)messageWithContent:(NSString *)content;

@end
