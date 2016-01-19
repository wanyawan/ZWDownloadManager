//
//  ZWDownloadedTableViewCell.h
//  ZWDownloadManger
//
//  Created by Alex on 16/1/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWFileFinshDownloadInfo.h"
@interface ZWDownloadedTableViewCell : UITableViewCell
@property (nonatomic ,strong)ZWFileFinshDownloadInfo *info;
@property (nonatomic ,strong)UIImageView *downloadedImageView;

@end
