//
//  AnimatedAvatarView.m
//  SDKTT
//
//  Created by 姚肖 on 2024/5/14.
//

#import "AnimatedAvatarView.h"

@interface AnimatedAvatarView()

@end

@implementation AnimatedAvatarView

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    UIImage *image = _imageView.image;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self setupViews];
    _imageView.image = image;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = self.bounds;
    backView.layer.cornerRadius = self.bounds.size.width / 2;
    backView.layer.masksToBounds = true;
    [self addSubview:backView];
    [self viewAddBorderAnimation:backView duration:1.0];
    
    UIView *backView1 = [[UIView alloc] init];
    backView1.frame = CGRectMake(5, 5, backView.bounds.size.width - 10, backView.bounds.size.height - 10);;
    backView1.layer.cornerRadius = (backView.bounds.size.width - 10) / 2;
    backView1.layer.masksToBounds = true;
    [backView addSubview:backView1];
    [self viewAddBorderAnimation:backView1 duration:1.1];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(5, 5, backView1.bounds.size.width - 10, backView1.bounds.size.height - 10);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.cornerRadius = (backView1.bounds.size.width - 10) / 2;
    _imageView.layer.masksToBounds = true;
    [backView1 addSubview:_imageView];
    [self viewAddBorderAnimation:_imageView duration:1.2];
    
}

- (void)viewAddBorderAnimation:(UIView *)view duration:(float)time {
    // 添加边框动画
    CALayer *borderLayer = [CALayer new];
    borderLayer.frame = view.bounds;
    borderLayer.cornerRadius = view.bounds.size.width / 2;
    borderLayer.borderWidth = 2.0;
    borderLayer.borderColor = [[UIColor greenColor] CGColor];
    [view.layer addSublayer:borderLayer];
    
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    pulseAnimation.duration = time;
    pulseAnimation.fromValue = @(0.0);
    pulseAnimation.toValue = @(2.0);
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = HUGE_VALF;
    [borderLayer addAnimation:pulseAnimation forKey:@"pulse"];
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
}

@end
