//
//  ZWDatabaseFileManger.h
//  ZWDownloader
//
//  Created by Alex on 15/12/2.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWDatabaseFileManger : NSObject
+ (BOOL)databaseDirIsExist;
+ (BOOL)mikDatabaseDir;
+ (BOOL)deleteDatabaseDir;
+ (NSString *)databaseDirPath;

@end
