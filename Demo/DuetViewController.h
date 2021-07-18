//
//  DuetViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
@class DuetViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol DuetViewControllerDelegate <NSObject>

- (void)duetChangeState:(DuetViewController *)controller;

@end;

@interface DuetViewController : UIViewController

@property (nonatomic, weak) id <DuetViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
