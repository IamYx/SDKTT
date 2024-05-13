//
//  TwoTableViewController.m
//  SDKTTDemo
//
//  Created by 姚肖 on 2024/4/10.
//

#import "TwoTableViewController.h"

@interface TwoTableViewController ()

@end

@implementation TwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillLayoutSubviews {
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    CGFloat bottomSafeAreaHeight = window.safeAreaInsets.bottom;
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - bottomSafeAreaHeight - 45);
    
    self.tableView.superview.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}

@end
