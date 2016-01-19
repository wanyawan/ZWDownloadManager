//
//  ZWDownloadingTableView.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 16/1/15.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZWDownloadingTableView.h"
#import "ZWDownloadManager.h"
#import "ZWDownloadingTableViewCell.h"
#import "ZWColor.h"
@implementation ZWDownloadingTableView
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[ZWDownloadQueueManger sharedInstance]downloadTaskCount];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([UIScreen mainScreen].bounds.size.width-16) * 0.45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWDownloadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadingCell"];
    if (cell == nil) {
        cell = [[ZWDownloadingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downloadingCell"];
    }
    [cell setInfo:[[ZWDownloadQueueManger sharedInstance].downloadinginfos objectAtIndex:indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section % 3) {
        case 0:
            cell.downloadingImageView.backgroundColor = [UIColor colorWithHexString:@"8C59A6"];
            break;
        case 1:
            cell.downloadingImageView.backgroundColor = [UIColor colorWithHexString:@"5D63B6"];
            break;
        case 2:
            cell.downloadingImageView.backgroundColor = [UIColor colorWithHexString:@"C75C70"];
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWFileDownloadingInfo *info = [[ZWDownloadQueueManger sharedInstance].downloadinginfos objectAtIndex:indexPath.section];
    switch (info.progressType) {
        case ZWDownloadProgressTypeDownloading:
            [[ZWDownloadQueueManger sharedInstance]pause:indexPath.section];
            break;
        case ZWDownloadProgressTypeWaiting:
            [[ZWDownloadQueueManger sharedInstance].downloadinginfos objectAtIndex:indexPath.section].progressType = ZWDownloadProgressTypePause;
            break;
        case ZWDownloadProgressTypePause:
            [[ZWDownloadQueueManger sharedInstance].downloadinginfos objectAtIndex:indexPath.section].progressType = ZWDownloadProgressTypeWaiting;
            [[ZWDownloadQueueManger sharedInstance]checkDownTaskCount];
            break;
        default:
            break;
    }
}

@end
