//
//  RCVoiceMessage.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"

@interface RCVoiceMessage : RCMessageContent

@property(nonatomic, strong) NSData* wavAudioData;
@property(nonatomic, assign) long duration;

-(RCVoiceMessage*)initWithAudioData:(NSData*)wavData duration:(long)duration;

+(NSString*)getClassObjectName;
+(int)getClassObjectFlag;
+(void)setObjectFlag:(int)objFlag;
@end
