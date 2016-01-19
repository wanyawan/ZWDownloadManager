//
//  ZWTemporaryFileManger.h
//  ZWDownloader
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWTemporaryFileManager : NSObject
+ (BOOL)temporaryDirIsExist;
+ (BOOL)mikTemporaryDir;
+ (BOOL)deleteTemporaryDir;
+ (NSString *)temporaryDirPath;
@end
