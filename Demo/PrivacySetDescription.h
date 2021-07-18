//
//  PrivacySetDescription.h
//  Demo
//
//  Created by bytedance on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface PrivacySetDescription : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableDictionary *state;

@end

NS_ASSUME_NONNULL_END
