//
//  ZWDownloadedTableView.m
//  ZWDownloadMangerLibrary
//
//  Created by Alex on 16/1/15.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZWDownloadedTableView.h"
#import "ZWDownloadManager.h"
#import "ZWDownloadedTableViewCell.h"
#import "ZWColor.h"

@implementation ZWDownloadedTableView
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
    return [ZWDownloadQueueManger sharedInstance].downloadedinfos.count;
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
    ZWDownloadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadedCell"];
    if (cell == nil ) {
        cell = [[ZWDownloadedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"downloadedCell"];
    }
    [cell setInfo:[[ZWDownloadQueueManger sharedInstance].downloadedinfos objectAtIndex:indexPath.section]];
    switch (indexPath.section % 3) {
        case 0:
            cell.downloadedImageView.backgroundColor = [UIColor colorWithHexString:@"8C59A6"];
            break;
        case 1:
            cell.downloadedImageView.backgroundColor = [UIColor colorWithHexString:@"5D63B6"];
            break;
        case 2:
            cell.downloadedImageView.backgroundColor = [UIColor colorWithHexString:@"C75C70"];
            break;
        default:
            break;
    }
    return cell;
}
@end
