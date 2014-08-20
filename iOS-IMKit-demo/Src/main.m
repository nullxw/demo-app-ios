//
//  main.m
//  iOS-IMKit-demo
//
//  Created by Heq.Shinoda on 14-5-26.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#ifdef DEBUG
#undef LOGTOFILE
#else
#define LOGTOFILE
#endif

int main(int argc, char *argv[])
{
#ifdef LOGTOFILE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex: 0];
    NSString *logPath = [documentDir stringByAppendingPathComponent:@"xsz.log"];
    NSLog(@"%@", logPath);
    freopen([logPath cStringUsingEncoding: NSASCIIStringEncoding], "a+", stdout);
    
    NSString *logPath2 = [documentDir stringByAppendingPathComponent:@"xsz2.log"];
    freopen([logPath2 cStringUsingEncoding: NSASCIIStringEncoding], "a+", stderr);
#endif
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
