//
//  TBViewController.h
//  Teemo
//
//  Created by Wu Kevin on 11/6/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TBNavigationView;


@interface TBViewController : UIViewController {
  TBNavigationView *_navigationView;
  UIView *_contentView;
  
  BOOL _viewAppeared;
  NSUInteger _appearedTimes;
}

- (void)layoutViews;

- (void)backButtonClicked:(id)sender;
- (void)leftButtonClicked:(id)sender;
- (void)rightButtonClicked:(id)sender;

@end


@interface TBNavigationView : UIView {
  UIButton *_backButton;
  UIButton *_leftButton;
  UILabel *_titleLabel;
  UIButton *_rightButton;
}

@property (nonatomic, strong, readonly) UIButton *backButton;
@property (nonatomic, strong, readonly) UIButton *leftButton;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIButton *rightButton;

- (void)showBackButton;
- (void)showLeftButton;
- (void)showRightButton;

@end
