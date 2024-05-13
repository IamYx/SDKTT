//
//  YXButton.h
//  SDKTT
//
//  Created by 姚肖 on 2024/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXButtonClickBlock)(void);

@interface YXButton : UIView

@property (nonatomic, strong)NSString *name;
@property (nonatomic, copy)YXButtonClickBlock buttonBlock;

@end

NS_ASSUME_NONNULL_END
