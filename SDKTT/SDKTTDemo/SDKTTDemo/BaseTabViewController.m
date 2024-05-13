//
//  BaseTabViewController.m
//  SDKTTDemo
//
//  Created by 姚肖 on 2024/4/10.
//

#import "BaseTabViewController.h"
#import "ViewController.h"
#import "TwoTableViewController.h"

@interface BaseTabViewController ()

@property (nonatomic, strong)UIButton *oneBtn;
@property (nonatomic, strong)UIButton *twoBtn;

@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ViewController *vc = [ViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.title = @"one";
    
    TwoTableViewController *vc1 = [TwoTableViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    vc1.title = @"two";
    self.viewControllers = @[nav, nav1];
    
    self.tabBar.hidden = YES;
    [self loadui];
}

- (void)loadui {
    
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    CGFloat bottomSafeAreaHeight = window.safeAreaInsets.bottom;
    UIView *yxtabBar = [[UIView alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - bottomSafeAreaHeight - 45, [UIScreen mainScreen].bounds.size.width - 40, 45)];
    yxtabBar.backgroundColor = [UIColor lightGrayColor];
    yxtabBar.layer.cornerRadius = 45/2;
    
    [self.view addSubview:yxtabBar];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"one" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.layer.masksToBounds = YES;
    button1.frame = CGRectMake(0, 0, yxtabBar.bounds.size.width / 2, 45);
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    [yxtabBar addSubview:button1];
    button1.layer.mask = [self layerFromButton:button1 org:UIRectCornerTopLeft];
    _oneBtn = button1;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"two" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.frame = CGRectMake(yxtabBar.bounds.size.width / 2, 0, yxtabBar.bounds.size.width / 2, 45);
    [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    [yxtabBar addSubview:button2];
    button2.layer.mask = [self layerFromButton:button2 org:UIRectCornerTopRight];
    _twoBtn = button2;
    
    _oneBtn.backgroundColor = [UIColor blueColor];
    _twoBtn.backgroundColor = [UIColor lightGrayColor];
    
}

- (CAShapeLayer *)layerFromButton:(UIButton *)btn org:(UIRectCorner)org {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btn.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                         cornerRadii:CGSizeMake(10, 10)];
    if (org == UIRectCornerTopRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                                       byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                             cornerRadii:CGSizeMake(10, 10)];
    }
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    return maskLayer;
}

- (void)button1Action:(UIButton *)btn {
    self.selectedIndex = 0;
    _oneBtn.backgroundColor = [UIColor blueColor];
    _twoBtn.backgroundColor = [UIColor lightGrayColor];
}

- (void)button2Action:(UIButton *)btn {
    self.selectedIndex = 1;
    _oneBtn.backgroundColor = [UIColor lightGrayColor];
    _twoBtn.backgroundColor = [UIColor blueColor];
}

@end
