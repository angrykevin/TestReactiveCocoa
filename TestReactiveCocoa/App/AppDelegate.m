//
//  AppDelegate.m
//  TestReactiveCocoa
//
//  Created by Wu Kevin on 3/25/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import "AppDelegate.h"
#import "RCMainViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  _window.backgroundColor = [UIColor whiteColor];
  
  RCMainViewController *vc = [[RCMainViewController alloc] init];
  _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
  
  [_window makeKeyAndVisible];
  return YES;
}


@end
