//
//  YXButton.m
//  SDKTT
//
//  Created by 姚肖 on 2024/4/8.
//

#import "YXButton.h"

@interface YXButton()

@property (nonatomic, strong)UIButton *button1;

@end

@implementation YXButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadui];
    }
    return self;
}

- (void)loadui {
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setTitle:@"按钮" forState:UIControlStateNormal];
    _button1.frame = self.bounds;
    _button1.layer.cornerRadius = 10;
    _button1.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    _button1.layer.shadowOffset = CGSizeMake(0, 2);
    _button1.layer.shadowOpacity = 0.5;
    _button1.layer.shadowRadius = 2;
    _button1.backgroundColor = [UIColor orangeColor];
    [_button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button1];
}

- (void)setName:(NSString *)name {
    
    _name = name;
    [self.button1 setTitle:name forState:UIControlStateNormal];
    
}

- (void)button1Action {
    self.buttonBlock();
}

@end
