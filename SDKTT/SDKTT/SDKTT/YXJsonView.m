//
//  YXJsonView.m
//  SDKTT
//
//  Created by 姚肖 on 2024/4/10.
//

#import "YXJsonView.h"

@interface YXJsonView()

@property(nonatomic, strong)NSDictionary *contentDic;

@property(nonatomic, strong)UIScrollView *vScrollView;

@end

@implementation YXJsonView

- (instancetype)initWithFrame:(CGRect)frame withJson:(NSDictionary *)jsonStr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentDic = jsonStr;
        [self loadui];
    }
    return self;
}

- (void)loadui {
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 10;
    
    _vScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_vScrollView];
    
    float y = [self addContentView:5 y:5 w:50 dic:_contentDic];
    
    [_vScrollView setContentSize:CGSizeMake(0, y + 20)];
}

- (float)addContentView:(float)x y:(float)y w:(float)w dic:(NSDictionary *)dic {
    
//    float keyW = (self.bounds.size.width - 10) * 0.2;
    float keyW = w;
    float keyH = (self.bounds.size.height - 10) / 10;
    
    float valueH = (self.bounds.size.height - 10) / 10;
    float valueW = (self.bounds.size.width - 10) - x - keyW;
    
    for (NSInteger i = 0; i < dic.allKeys.count; i++) {
        
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, keyW, keyH)];
        keyLabel.text = dic.allKeys[i];
        keyLabel.textColor = [UIColor whiteColor];
        keyLabel.numberOfLines = 0;
        [keyLabel sizeToFit];
        [_vScrollView addSubview:keyLabel];
        
        id value = [dic objectForKey:keyLabel.text];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic1 = value;
            y = [self addContentView:5 + keyW y:y w:100 dic:dic1];
            
        } else {
            UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(keyW + x, y, valueW, valueH)];
            valueLabel.text = [NSString stringWithFormat:@"%@", value];
            valueLabel.textColor = [UIColor whiteColor];
            if (valueLabel.text.length <= 0) {
                valueLabel.text = @" ";
            }
            valueLabel.numberOfLines = 0;
            [valueLabel sizeToFit];
            [_vScrollView addSubview:valueLabel];
            
            UILongPressGestureRecognizer *valueTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(valueTapAction:)];
            valueLabel.userInteractionEnabled = YES;
            [valueLabel addGestureRecognizer:valueTap];
            
            y = CGRectGetMaxY(valueLabel.frame);
        }
        
    }
    
    return y;
}

- (void)valueTapAction:(UILongPressGestureRecognizer *)longTap {
    
    UILabel *label = (UILabel *)longTap.view;
    
    if (longTap.state == UIGestureRecognizerStateBegan) {
        label.backgroundColor = [UIColor orangeColor];
    } else {
        label.backgroundColor = [UIColor clearColor];
    }
    
    if (longTap.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"长按结束");
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = label.text;
    }
    
}

@end
