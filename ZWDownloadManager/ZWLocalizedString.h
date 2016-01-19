//
//  SULocalizedString.h
//  SUDownloader
//
//  Created by Alex on 15/12/8.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWCommon.h"

@interface ZWLocalizedString : NSObject
+ (ZWLocalizedString *)sharedInstance;

- (NSString *)localizedStringWithZWDownloadProgressType:(ZWDownloadProgressType)type;
@end
