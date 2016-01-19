//
//  SULocalizedString.m
//  SUDownloader
//
//  Created by Alex on 15/12/8.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "ZWLocalizedString.h"
static ZWLocalizedString *sharedInstance = nil;

@implementation ZWLocalizedString
+ (ZWLocalizedString *)sharedInstance
{
    static dispatch_once_t ZWLocalizedStringOnceToken;
    
    dispatch_once(&ZWLocalizedStringOnceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}
- (NSString *)localizedStringWithZWDownloadProgressType:(ZWDownloadProgressType)type
{
    NSString *str = nil;
    switch (type) {
        case ZWDownloadProgressTypeDownloading:
            str = @"";
            break;
        case ZWDownloadProgressTypePause:
            str = @"Pause";
            break;
        case ZWDownloadProgressTypeWaiting:
            str = @"Pending";
            break;
        default:
            break;
    }
    return str;
}
@end
