//
//  StitchViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
@class StitchViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol StitchViewControllerDelegate <NSObject>

- (void)stitchChangeState:(StitchViewController *)controller;

@end;

@interface StitchViewController : UIViewController

@property (nonatomic, weak) id <StitchViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
