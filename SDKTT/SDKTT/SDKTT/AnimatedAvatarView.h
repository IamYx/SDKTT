//
//  AnimatedAvatarView.h
//  SDKTT
//
//  Created by 姚肖 on 2024/5/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnimatedAvatarView : UIView

@property(nonatomic, strong)UIImageView *imageView;
- (void)setImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
