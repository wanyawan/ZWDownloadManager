//
//  ZWDownloadingTableViewCell.m
//  ZWDownloadManger
//
//  Created by Alex on 16/1/18.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZWDownloadingTableViewCell.h"
#import "ZWLocalizedString.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ZWDownloadingTableViewCell
{
    UIView *blackView;
    UILabel *titleLabel;
    UILabel *progressLabel;
    UILabel *stateLabel;
    UILabel *qualityLabel;
    UILabel *speedLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _downloadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, ScreenWidth-16, (ScreenWidth-16) * 0.45)];
        _downloadingImageView.contentMode = UIViewContentModeScaleAspectFill;
        _downloadingImageView.clipsToBounds = YES;
        [self addSubview:_downloadingImageView];
        
        blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _downloadingImageView.frame.size.width, _downloadingImageView.frame.size.height)];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.7;
        [_downloadingImageView addSubview:blackView];
        
        
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
        
        stateLabel = [[UILabel alloc]init];
        stateLabel.textColor = [UIColor whiteColor];
        stateLabel.font = [UIFont systemFontOfSize:26];
        stateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:stateLabel];
        NSArray *stateLabelConstraints = @[
                                           [NSLayoutConstraint constraintWithItem:stateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                                           [NSLayoutConstraint constraintWithItem:stateLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:10],
                                           [NSLayoutConstraint constraintWithItem:stateLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]
                                           ];
        [self addConstraints:stateLabelConstraints];
        
        progressLabel = [[UILabel alloc]init];
        progressLabel.textAlignment = NSTextAlignmentLeft;
        progressLabel.textColor = [UIColor whiteColor];
        progressLabel.numberOfLines = 1;
        progressLabel.font = [UIFont systemFontOfSize:12];
        progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:progressLabel];
        NSArray *progressLabelContraints  = @[
                                              [NSLayoutConstraint constraintWithItem:progressLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:20],
                                              [NSLayoutConstraint constraintWithItem:progressLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:- 10],
                                              [NSLayoutConstraint constraintWithItem:progressLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0]
                                              ];
        [self addConstraints:progressLabelContraints];
        
        speedLabel = [[UILabel alloc]init];
        speedLabel.textAlignment = NSTextAlignmentRight;
        speedLabel.textColor = [UIColor whiteColor];
        speedLabel.numberOfLines = 1;
        speedLabel.font = [UIFont systemFontOfSize:12];
        speedLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:speedLabel];
        NSArray *speedLabelContraints  = @[
                                           [NSLayoutConstraint constraintWithItem:speedLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-20],
                                           [NSLayoutConstraint constraintWithItem:speedLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:- 10],
                                           [NSLayoutConstraint constraintWithItem:speedLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0]
                                           ];
        [self addConstraints:speedLabelContraints];
    
    }
    return self;
}
- (void)setInfo:(ZWFileDownloadingInfo *)info
{
    if (_info) {
        [_info removeObserver:self forKeyPath:@"downloadBytes"];
        [_info removeObserver:self forKeyPath:@"totalBytes"];
        [_info removeObserver:self forKeyPath:@"progressType"];
        [_info removeObserver:self forKeyPath:@"speed"];
    }
    _info = info;
    
    [_info addObserver:self forKeyPath:@"downloadBytes" options:NSKeyValueObservingOptionNew context:nil];
    [_info addObserver:self forKeyPath:@"totalBytes" options:NSKeyValueObservingOptionNew context:nil];
    [_info addObserver:self forKeyPath:@"progressType" options:NSKeyValueObservingOptionNew context:nil];
    [_info addObserver:self forKeyPath:@"speed" options:NSKeyValueObservingOptionNew context:nil];
    titleLabel.text = _info.fileTitle;
    
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *speedString;
    if (_info.progressType == ZWDownloadProgressTypeDownloading) {
        if (_info.showSpeed <1024) {
            speedString = [NSString stringWithFormat:@"%@B/S",[NSNumber numberWithFloat:_info.showSpeed]];
        }else if (_info.showSpeed >1024 && _info.showSpeed < 1024*1024)
        {
            speedString = [NSString stringWithFormat:@"%.1fKB/S",_info.showSpeed/1024];
        }else if (_info.showSpeed > 1024 * 1024)
        {
            speedString = [NSString stringWithFormat:@"%.2fMB/S",_info.showSpeed/1024/1024];
        }
    }else
    {
        speedString = @"";
    }
    speedLabel.text = speedString;
    
    
    if (_info.showDownloadBytes == 0 && _info.showTotalBytes == 0) {
        progressLabel.text = @"";
        if (_info.progressType == ZWDownloadProgressTypeDownloading) {
            stateLabel.text = @"0%";
        }else{
            stateLabel.text = [[ZWLocalizedString sharedInstance]localizedStringWithZWDownloadProgressType:_info.progressType];
        }
        blackView.frame = CGRectMake(0, 0, _downloadingImageView.frame.size.width, _downloadingImageView.frame.size.height);
    }else{
        NSString *totalString;
        if (_info.showTotalBytes <1024) {
            totalString = [NSString stringWithFormat:@"%@B",[NSNumber numberWithFloat:_info.showTotalBytes]];
        }else if (_info.showTotalBytes >1024 && _info.showTotalBytes < 1024*1024)
        {
            totalString = [NSString stringWithFormat:@"%.1fKB",_info.showTotalBytes/1024];
        }else if (_info.showTotalBytes > 1024 * 1024)
        {
            totalString = [NSString stringWithFormat:@"%.2fMB",_info.showTotalBytes/1024/1024];
        }
        NSString *downloadString;
        if (_info.showDownloadBytes <1024) {
            downloadString = [NSString stringWithFormat:@"%@B",[NSNumber numberWithFloat:_info.showDownloadBytes]];
        }else if (_info.showDownloadBytes >1024 && _info.showDownloadBytes < 1024*1024)
        {
            downloadString = [NSString stringWithFormat:@"%.1fKB",_info.showDownloadBytes/1024];
        }else if (_info.showDownloadBytes > 1024 * 1024)
        {
            downloadString = [NSString stringWithFormat:@"%.2fMB",_info.showDownloadBytes/1024/1024];
        }
        progressLabel.text = [NSString stringWithFormat:@"%@/%@",downloadString,totalString];
        
        float progress = ((_info.showDownloadBytes*1.0)/_info.showTotalBytes) *100;
        if (progress > 0 && progress < 100) {
            CGFloat originX = progress/100 * _downloadingImageView.bounds.size.width;
            CGFloat width = (1 - progress/100) * _downloadingImageView.bounds.size.width;
            blackView.frame = CGRectMake(originX, 0, width, _downloadingImageView.bounds.size.height);
            if (_info.progressType == ZWDownloadProgressTypeDownloading) {
                stateLabel.text = [NSString stringWithFormat:@"%.0f%%",progress];
            }else{
                stateLabel.text = [[ZWLocalizedString sharedInstance]localizedStringWithZWDownloadProgressType:_info.progressType];
            }
        }
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    __weak ZWDownloadingTableViewCell *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:@"totalBytes"]) {
            _info.showTotalBytes = [[change objectForKey:@"new"] floatValue];
        }
        if ([keyPath isEqualToString:@"downloadBytes"]) {
            _info.showDownloadBytes = [[change objectForKey:@"new"] floatValue];
        }
        if ([keyPath isEqualToString:@"progressType"]) {
            _info.showProgressType = [[change objectForKey:@"new"]intValue];
        }
        if ([keyPath isEqualToString:@"speed"]) {
            _info.showSpeed = [[change objectForKey:@"new"]floatValue];
        }
        
        [weakSelf setNeedsLayout];
    });
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
