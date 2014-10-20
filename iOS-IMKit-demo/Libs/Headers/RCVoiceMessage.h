//
//  RCVoiceMessage.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"

@interface RCVoiceMessage : RCMessageContent //<RCMessagePersistentCompatible, RCMessageCoding>

@property(nonatomic, strong) NSData* wavAudioData;
@property(nonatomic, assign) long duration;
+(instancetype)messageWithAudio:(NSData *)audioData duration:(long)duration;
@end
