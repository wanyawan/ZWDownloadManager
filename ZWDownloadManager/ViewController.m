//
//  ViewController.m
//  ZWDownloadManager
//
//  Created by Alex on 16/1/19.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ZWDownloadManager.h"
#import "ZWDownloadingTableView.h"
#import "ZWDownloadedTableView.h"
@interface ViewController ()
@property (nonatomic, strong)UIScrollView *downloadScrollView;
@property (nonatomic, strong)UISegmentedControl *segmentedControl;
@property (nonatomic, strong)ZWDownloadingTableView *downloadingTableView;
@property (nonatomic, strong)ZWDownloadedTableView *downloadedTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![ZWDownloadFileManager fileDirIsExist]){
        [ZWDownloadFileManager mikFileDir];
    }// 创建目录
    if (![ZWDatabaseFileManager databaseDirIsExist]) {
        [ZWDatabaseFileManager mikDatabaseDir];
    }
    if (![ZWTemporaryFileManager temporaryDirIsExist]) {
        [ZWTemporaryFileManager mikTemporaryDir];
    }
    
    [self initTestDownloadInfo];
    [self initSegment];
    [self initScrollViewAndTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadingTableViewChange:) name:@"downloadingTableViewReloadData" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downloadedTableViewChange:) name:@"downloadedTableViewReloadData" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSegment
{
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"Downloading",@"Complete"]];
    _segmentedControl.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 20, 200, 30);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmented:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
}
- (void)initScrollViewAndTableView
{
    _downloadScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    _downloadScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, [UIScreen mainScreen].bounds.size.height-50);
    _downloadScrollView.scrollEnabled = NO;
    [self.view addSubview:_downloadScrollView];
    
    _downloadingTableView = [[ZWDownloadingTableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    //    _downloadingTableView.backgroundColor = [UIColor redColor];
    [_downloadScrollView addSubview:_downloadingTableView];
    
    _downloadedTableView = [[ZWDownloadedTableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    //    _downloadedTableView.backgroundColor = [UIColor blueColor];
    [_downloadScrollView addSubview:_downloadedTableView];
}
- (void)segmented:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            _downloadScrollView.contentOffset = CGPointMake(0, 0);
        }break;
        case 1:{
            _downloadScrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
        }break;
        default:
            break;
    }
}
- (void)downloadingTableViewChange:(NSNotification *)notification
{
    [_downloadingTableView reloadData];
}
- (void)downloadedTableViewChange:(NSNotification *)notification
{
    [_downloadedTableView reloadData];
}
- (void)initTestDownloadInfo
{
    ZWFileDownloadingInfo *info1 = [[ZWFileDownloadingInfo alloc]init];
    info1.fileId = @"1";
    info1.fileTitle = @"test 01";
    info1.fileUUID = [[NSUUID UUID]UUIDString];
    info1.fileDownloadUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    info1.progressType = ZWDownloadProgressTypePause;
    [[ZWDownloadQueueManger sharedInstance]addDownloadTask:info1];
    
    ZWFileDownloadingInfo *info2 = [[ZWFileDownloadingInfo alloc]init];
    info2.fileId = @"2";
    info2.fileTitle = @"test 02";
    info2.fileUUID = [[NSUUID UUID]UUIDString];
    info2.fileDownloadUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    info2.progressType = ZWDownloadProgressTypePause;
    [[ZWDownloadQueueManger sharedInstance]addDownloadTask:info2];
    
    ZWFileDownloadingInfo *info3 = [[ZWFileDownloadingInfo alloc]init];
    info3.fileId = @"3";
    info3.fileTitle = @"test 03";
    info3.fileUUID = [[NSUUID UUID]UUIDString];
    info3.fileDownloadUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    info3.progressType = ZWDownloadProgressTypePause;
    [[ZWDownloadQueueManger sharedInstance]addDownloadTask:info3];
    
    ZWFileDownloadingInfo *info4 = [[ZWFileDownloadingInfo alloc]init];
    info4.fileId = @"3";
    info4.fileTitle = @"test 04";
    info4.fileUUID = [[NSUUID UUID]UUIDString];
    info4.fileDownloadUrl = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    info4.progressType = ZWDownloadProgressTypePause;
    [[ZWDownloadQueueManger sharedInstance]addDownloadTask:info4];
    
}


@end
