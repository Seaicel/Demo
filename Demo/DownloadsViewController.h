//
//  DownloadsViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
@class DownloadsViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol DownloadsViewControllerDelegate <NSObject>

- (void)downloadsChangeState:(DownloadsViewController *)controller;

@end

@interface DownloadsViewController : UIViewController

@property (nonatomic, weak) id <DownloadsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
