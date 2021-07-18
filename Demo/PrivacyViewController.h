//
//  PrivacyViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

typedef NS_ENUM (NSInteger, SETTING_STATES) {
    DOWNLOADS_OFF,
    DOWNLOADS_ON,
    COMMENTS_EVERYONE,
    COMMENTS_FRIENDS,
    COMMENTS_NO_ONE,
    DUET_EVERYONE,
    DUET_FRIENDS,
    DUET_ONLY_ME,
    STITCH_EVERYONE,
    STITCH_FRIENDS,
    STITCH_ONLY_ME,
    LIKED_VIDEO_EVERYONE,
    LIKED_VIDEO_ONLY_ME,
    DIRECT_MESSAGE_EVERYONE,
    DIRECT_MESSAGE_FRIENDS,
    DIRECT_MESSAGE_NO_ONE,
    BLOCKED_ACCOUNTS_DEFAULT
};

NS_ASSUME_NONNULL_BEGIN

@interface PrivacyViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
