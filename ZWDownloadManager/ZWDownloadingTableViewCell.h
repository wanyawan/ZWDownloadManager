//
//  ZWDownloadingTableViewCell.h
//  ZWDownloadManger
//
//  Created by Alex on 16/1/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWDownloadManager.h"

@interface ZWDownloadingTableViewCell : UITableViewCell
@property (nonatomic, strong)ZWFileDownloadingInfo *info;
@property (nonatomic, strong)UIImageView *downloadingImageView;
@end
