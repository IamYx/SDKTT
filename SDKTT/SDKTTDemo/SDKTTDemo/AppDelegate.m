//
//  AppDelegate.m
//  SDKTTDemo
//
//  Created by 姚肖 on 2024/4/7.
//

#import "AppDelegate.h"
#import "BaseTabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] init];
    self.window.rootViewController = [BaseTabViewController new];
    
    return YES;
}

@end
