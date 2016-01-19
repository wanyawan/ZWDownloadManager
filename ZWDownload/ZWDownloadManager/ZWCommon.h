//
//  ZWCommon.h
//  Pods
//
//  Created by Alex on 16/1/14.
//
//

#ifndef ZWCommon_h
#define ZWCommon_h


#endif /* ZWCommon_h */

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f)
#define IS_IOS_5 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f)

typedef NS_ENUM(NSUInteger ,ZWDownloadProgressType)
{
    ZWDownloadProgressTypeWaiting = 0,
    ZWDownloadProgressTypePause,
    ZWDownloadProgressTypeDownloading,
    ZWDownloadProgressTypeDownloadFinsh,
};