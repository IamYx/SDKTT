//
//  YXJsonView.h
//  SDKTT
//
//  Created by 姚肖 on 2024/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXJsonView : UIView

- (instancetype)initWithFrame:(CGRect)frame withJson:(NSDictionary *)jsonStr;

@end

NS_ASSUME_NONNULL_END
