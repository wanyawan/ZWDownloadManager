//
//  ZWDownloadedTableViewCell.m
//  ZWDownloadManger
//
//  Created by Alex on 16/1/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZWDownloadedTableViewCell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ZWDownloadedTableViewCell
{
    UILabel *titleLabel;
    UILabel *progressLabel;
    UILabel *qualityLabel;
    UILabel *newLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _downloadedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, ScreenWidth-16, (ScreenWidth-16) * 0.45)];
        _downloadedImageView.contentMode = UIViewContentModeScaleAspectFill;
        _downloadedImageView.clipsToBounds = YES;
        [self addSubview:_downloadedImageView];
        UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _downloadedImageView.frame.size.width, _downloadedImageView.frame.size.height)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.2;
        [_downloadedImageView addSubview:blackView];
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:titleLabel];
        NSArray *titleConstraints = @[
                                      [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:-120],
                                      [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:25],
                                      [NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
        [self addConstraints:titleConstraints];
        

    }
    return self;
}
- (void)setInfo:(ZWFileFinshDownloadInfo *)info
{
    _info = info;
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    titleLabel.text = _info.fileTitle;
    NSString *totalString;
    if (_info.totalBytes <1024) {
        totalString = [NSString stringWithFormat:@"%@B",[NSNumber numberWithFloat:_info.totalBytes]];
    }else if (_info.totalBytes >1024 && _info.totalBytes < 1024*1024)
    {
        totalString = [NSString stringWithFormat:@"%.1fKB",_info.totalBytes/1024];
    }else if (_info.totalBytes > 1024 * 1024)
    {
        totalString = [NSString stringWithFormat:@"%.2fMB",_info.totalBytes/1024/1024];
    }
    progressLabel.text = totalString;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
