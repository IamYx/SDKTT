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
@property (nonatomic, strong)UILabel *outLabel;

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
    
    YXButton *button3 = [[YXButton alloc] initWithFrame:CGRectMake(140, 220, 100, 40)];
    button3.name = @"输出字符";
    button3.buttonBlock = ^{
        [weakSelf outText];
    };
    [self.view addSubview:button3];
    
    AnimatedAvatarView *acatarView = [[AnimatedAvatarView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(button2.frame) + 20, 80, 80)];
    [acatarView setImage:[UIImage imageNamed:@"IMG_1187.JPG"]];
    [self.view addSubview:acatarView];
    
    _outLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.index * 10, 280 + self.index * 10, 360, 400)];
    _outLabel.backgroundColor = [UIColor whiteColor];
    _outLabel.numberOfLines = 0;
    [self.view addSubview:_outLabel];
    
}

- (void)outText {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger index = self.outLabel.text.length;
        NSString *content = @"[2024-05-14 23:59:51:302] file:NIMApmEventRecorder.mm line: 98)<<<<Apm: addErrorToApmEventType:4 sn:5eaf074d-fd20-4bad-a0d3-3d794492bb1c error:<NIMSendMessageError: self.msgId=(null), self.clientId=5eaf074d-fd20-4bad-a0d3-3d794492bb1c, self.appkey=701994af7b0559728f9ee602a6f3c342, self.sdkVersion=9.6.4, self.messageTime=1715702391.300382, self.fromAccid=90040, self.toAccid=(null), self.deviceId=C9CA5CDD-2BF1-47F1-AA15-3D52FF66097F, self.eid=, self.sendMessageErrorSessionType=1, self.roomId=0, self.teamId=22822832067, self.result=0, self.failReason=>";
        if (index < (content.length - 1)) {
            NSString *a = [content substringToIndex:(index + 1)];
            self.outLabel.text = a;
            [self outText];
        } else {
            self.outLabel.text = content;
        }
    });
    
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
