//
//  ViewController.m
//  SDKTTDemo
//
//  Created by 姚肖 on 2024/4/7.
//

#import "ViewController.h"
#import <SDKTT/YXSDKTT.h>
#import "WKWebViewController.h"

@interface ViewController ()

@property (nonatomic, assign)NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadui];
    
}

- (void)loadui {
    __weak ViewController *weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    YXButton *button = [[YXButton alloc] initWithFrame:CGRectMake(20, 100, 120, 40)];
    button.name = @"WkWebView";
    button.buttonBlock = ^{
        [weakSelf presentViewController:[WKWebViewController new] animated:YES completion:nil];
    };
    [self.view addSubview:button];
    
    YXButton *button1 = [[YXButton alloc] initWithFrame:CGRectMake(20, 160, 100, 40)];
    button1.name = @"输入弹窗";
    button1.buttonBlock = ^{
        YXAlertView *alertView = [[YXAlertView alloc] initWithTitle:@"提示" message:@"详细信息" inputs:@[@"账号", @"密码"] buttons:@[@"确定", @"取消"]];
        [alertView showAlertView:weakSelf];
        alertView.buttonBlock = ^(NSInteger index, NSArray * arr) {
            NSLog(@"=== %ld, %@", index, arr);
        };
    };
    [self.view addSubview:button1];
    
    YXButton *button2 = [[YXButton alloc] initWithFrame:CGRectMake(20, 220, 100, 40)];
    button2.name = @"sheet弹窗";
    button2.buttonBlock = ^{
        YXAlertView *alertView = [[YXAlertView alloc] initWithTitle:@"提示" message:@"详细信息" buttons:@[@"获取用户信息", @"更新用户信息"]];
        [alertView showAlertView:weakSelf];
        alertView.buttonBlock = ^(NSInteger index, NSArray * arr) {
            if(index == 0) {
                [[YXNetwork sharedManager] sendRequest:@"https://open.yunxinapi.com/im/v2/users/ceshi8" params:nil method:@"GET" successBlock:^(NSDictionary * _Nullable response) {
                    
                    [weakSelf showRequestData:response];
                    
                } failureBlcok:^(NSError * _Nullable error) {
                    
                }];
            } else {
                [[YXNetwork sharedManager] sendRequest:@"https://open.yunxinapi.com/im/v2/users/ceshi8" params:@{@"extension":@"888"} method:@"PATCH" successBlock:^(NSDictionary * _Nullable response) {
                    
                } failureBlcok:^(NSError * _Nullable error) {
                    
                }];
            }
        };
    };
    [self.view addSubview:button2];
    
    AnimatedAvatarView *acatarView = [[AnimatedAvatarView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(button2.frame) + 20, 80, 80)];
    [acatarView setImage:[UIImage imageNamed:@"IMG_1187.JPG"]];
    [self.view addSubview:acatarView];
}

- (void)showRequestData:(NSDictionary *)response {
    YXJsonView *jsonView = [[YXJsonView alloc] initWithFrame:CGRectMake(20 + self.index * 10, 280 + self.index * 10, 360, 400) withJson:response];
    [self.view addSubview:jsonView];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(jsonViewAction:)];
    [jsonView addGestureRecognizer:panGes];
    
    self.index++;
}

- (void)jsonViewAction:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(gestureRecognizer.view.center.x + translation.x,
                                    gestureRecognizer.view.center.y);
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        gestureRecognizer.view.center = newCenter;
        [gestureRecognizer setTranslation:CGPointZero inView:self.view];
        
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        // 获取位移数据
        CGFloat offsetX = newCenter.x;
        CGFloat offsetY = newCenter.y;
        // 对位移数据进行判断或处理
        if (offsetX > [UIScreen mainScreen].bounds.size.width || offsetX < 0) {
            [UIView animateWithDuration:0.6 animations:^{
                gestureRecognizer.view.alpha = 0.0;
            } completion:^(BOOL finished) {
            
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [gestureRecognizer.view removeFromSuperview];
                self.index--;
            });
        }
        
    }
    
}

@end
