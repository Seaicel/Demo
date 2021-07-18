//
//  DirectMessageViewController.h
//  Demo
//
//  Created by bytedance on 2021/7/15.
//

#import <UIKit/UIKit.h>
@class DirectMessageViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol DirectMessageViewControllerDelegate <NSObject>


- (void)directMessageChangeState:(DirectMessageViewController *)controller;

@end

@interface DirectMessageViewController : UIViewController

@property (nonatomic, weak) id <DirectMessageViewControllerDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
