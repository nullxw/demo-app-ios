//
//  RCImageMessage.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"
#import <UIKit/UIKit.h>

@interface RCImageMessage : RCMessageContent
@property(nonatomic, strong) UIImage* thumbnailImage;
@property(nonatomic, strong) NSString* imageKey;
@property(nonatomic, strong) NSString* imageUri;
@property(nonatomic, strong) UIImage* originalImage;

-(RCImageMessage*)initWithImagePath:(NSString*)imageUri;

-(RCImageMessage*)initWithOriginalImage:(UIImage*)oriImage;

+(NSString*)getClassObjectName;
+(int)getClassObjectFlag;
+(void)setObjectFlag:(int)objFlag;
@end
