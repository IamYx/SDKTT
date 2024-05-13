//
//  YXAlertView.h
//  SDKTT
//
//  Created by 姚肖 on 2024/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXAlertClickBlock)(NSInteger, NSArray*);

@interface YXAlertView : UIView


@property (nonatomic, copy)YXAlertClickBlock buttonBlock;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message inputs:(NSArray *)inputs buttons:(NSArray *)buttons;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons;
- (void)showAlertView:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
