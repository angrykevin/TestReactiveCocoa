//
//  UIViewControllerExtentions.h
//  Teemo
//
//  Created by Wu Kevin on 8/27/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extentions)

- (void)presentChildViewController:(UIViewController *)childViewController inView:(UIView *)containerView;

- (void)dismissChildViewController:(UIViewController *)childViewController;

@end
