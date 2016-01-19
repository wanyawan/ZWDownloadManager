//
//  PTLAppDelegate.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 01/14/2016.
//  Copyright (c) 2016 Alex. All rights reserved.
//

#import "AFNetworking.h"

@interface ZWURLSessionManger : AFURLSessionManager
+ (ZWURLSessionManger *)sharedInstance;
@end
