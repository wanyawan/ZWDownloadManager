//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//
#import "ZWURLSessionManager.h"
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
static ZWURLSessionManager *sharedInstance = nil;
@implementation ZWURLSessionManager
+ (ZWURLSessionManager *)sharedInstance
{
    static dispatch_once_t ZWURLSessionManagerOnceToken;
    dispatch_once(&ZWURLSessionManagerOnceToken,^{
        if (IS_IOS_8) {
            sharedInstance = [[[self class]alloc]initWithSessionConfiguration: [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.zwdownloadmanager.www"]];
        }else
        {
            sharedInstance = [[[self class]alloc]initWithSessionConfiguration: [NSURLSessionConfiguration defaultSessionConfiguration]];
        }
    });
    return sharedInstance;
}

@end
