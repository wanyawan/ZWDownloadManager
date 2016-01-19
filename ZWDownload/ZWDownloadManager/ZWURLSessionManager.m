//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//
#import "ZWURLSessionManger.h"
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
static ZWURLSessionManger *sharedInstance = nil;
@implementation ZWURLSessionManger
+ (ZWURLSessionManger *)sharedInstance
{
    static dispatch_once_t ZWURLSessionMangerOnceToken;
    dispatch_once(&ZWURLSessionMangerOnceToken,^{
        if (IS_IOS_8) {
            sharedInstance = [[[self class]alloc]initWithSessionConfiguration: [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.zwdownloadmanger.www"]];
        }else
        {
            sharedInstance = [[[self class]alloc]initWithSessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
        }
    });
    return sharedInstance;
}

@end
