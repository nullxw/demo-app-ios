//
//  RCImageMessage.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-13.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import "RCMessageContent.h"
#import <UIKit/UIKit.h>

@interface RCImageMessage : RCMessageContent //<RCMessageCoding>
@property(nonatomic, strong) UIImage* thumbnailImage;
@property(nonatomic, strong) NSString* imageUrl;
@property(nonatomic, strong) UIImage* originalImage;

+(instancetype)messageWithImage:(UIImage *)image;
+(instancetype)messageWithImageURI:(NSString *)imageURI;

@end
