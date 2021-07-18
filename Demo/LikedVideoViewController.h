//
//  LikedVideoViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
@class LikedVideoViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol LikedVideoViewControllerDelegate <NSObject>

- (void)likedVideoChangeState:(LikedVideoViewController *)controller;

@end;

@interface LikedVideoViewController : UIViewController

@property (nonatomic, weak) id <LikedVideoViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
