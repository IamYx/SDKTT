//
//  YXAlertView.m
//  SDKTT
//
//  Created by 姚肖 on 2024/4/8.
//

#import "YXAlertView.h"

@interface YXAlertView()

@property (nonatomic, strong)UIAlertController *alertC;

@end

@implementation YXAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons {
    __weak YXAlertView *weakSelf = self;
    if (self = [super init])
    {
        self.alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        [_alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        for (NSInteger i = 0; i < buttons.count; i++) {
            [_alertC addAction:[UIAlertAction actionWithTitle:buttons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSMutableArray *muArr = [[NSMutableArray alloc] init];
                for (NSInteger j = 0; j < weakSelf.alertC.textFields.count; j++) {
                    UITextField *tf = weakSelf.alertC.textFields[j];
                    [muArr addObject:tf.text];
                }
                self.buttonBlock(i, muArr);
                
            }]];
        }
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message inputs:(NSArray *)inputs buttons:(NSArray *)buttons {
    
    __weak YXAlertView *weakSelf = self;
    if (self = [super init])
    {
        self.alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        for (NSInteger i = 0; i < inputs.count; i++) {
            [_alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = inputs[i];
            }];
        }
        
        for (NSInteger i = 0; i < buttons.count; i++) {
            [_alertC addAction:[UIAlertAction actionWithTitle:buttons[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSMutableArray *muArr = [[NSMutableArray alloc] init];
                for (NSInteger j = 0; j < weakSelf.alertC.textFields.count; j++) {
                    UITextField *tf = weakSelf.alertC.textFields[j];
                    [muArr addObject:tf.text];
                }
                self.buttonBlock(i, muArr);
                
            }]];
        }
    }
    
    return self;
}

- (void)showAlertView:(UIViewController *)vc {
    
    [vc presentViewController:_alertC animated:YES completion:nil];
    
}

@end
