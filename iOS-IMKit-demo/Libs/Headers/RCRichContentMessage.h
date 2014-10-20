//
//  RCRichContentMessage.h
//  iOS-IMLib
//
//  Created by Gang Li on 10/17/14.
//  Copyright (c) 2014 Heq.Shinoda. All rights reserved.
//

#import "RCMessageContent.h"
#import <UIKit/UIKit.h>

@interface RCRichContentMessage : RCMessageContent

@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *digest; //content
@property(nonatomic, strong)NSString *imageURL;  //url
@property(nonatomic, strong)NSString *extra; //extra


+(instancetype)messageWithTitle:(NSString *) title
                         digest:(NSString *)digest
                       imageURL:(NSString *)imageURL
                          extra:(NSString *)extra;
@end
