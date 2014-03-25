//
//  TBViewController.m
//  Teemo
//
//  Created by Wu Kevin on 11/6/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBViewController.h"
#import "TBCommon.h"
#import "UILabelExtentions.h"

@implementation TBViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.wantsFullScreenLayout = YES;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _navigationView = [[TBNavigationView alloc] init];
  [_navigationView.backButton addTarget:self
                                 action:@selector(backButtonClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
  [_navigationView.leftButton addTarget:self
                                 action:@selector(leftButtonClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
  [_navigationView.rightButton addTarget:self
                                  action:@selector(rightButtonClicked:)
                        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_navigationView];
  
  
  _contentView = [[UIView alloc] init];
  _contentView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:_contentView];
  
}


- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  _viewAppeared = YES;
  _appearedTimes++;
}

- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  _viewAppeared = NO;
}


- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  [self layoutViews];
}

- (void)layoutViews
{
  
  [_navigationView sizeToFit];
  _navigationView.frame = CGRectMake(0.0, 20.0, _navigationView.width, _navigationView.height);
  
  if ( _navigationView.hidden ) {
    _contentView.frame = self.view.bounds;
  } else {
    _contentView.frame = CGRectMake(0.0, _navigationView.bottomY, self.view.width, self.view.height - _navigationView.bottomY);
  }
}


- (void)backButtonClicked:(id)sender
{
  TKPRINTMETHOD();
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftButtonClicked:(id)sender
{
  TKPRINTMETHOD();
}

- (void)rightButtonClicked:(id)sender
{
  TKPRINTMETHOD();
}

@end



@implementation TBNavigationView

- (id)init
{
  self = [super init];
  if (self) {
    
    self.backgroundColor = [UIColor colorWithPatternImage:TBCreateImage(@"navbar_bg.png")];
    
    
    UIButton *button = [[UIButton alloc] init];
    button.normalBackgroundImage = [TBCreateImage(@"navbar_bt_back.png") resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 13.0, 0.0, 5.0)];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.exclusiveTouch = YES;
    button.hidden = YES;
    [self addSubview:button];
    _backButton = button;
    _backButton.normalTitle = NSLocalizedString(@"Back", @"");
    
    
    button = [[UIButton alloc] init];
    button.normalBackgroundImage = [TBCreateImage(@"navbar_bt_normal.png") resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 6.0, 14.0, 6.0)];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.exclusiveTouch = YES;
    button.hidden = YES;
    [self addSubview:button];
    _leftButton = button;
    
    
    _titleLabel = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:20.0]
                               textColor:[UIColor whiteColor]
                           textAlignment:NSTextAlignmentCenter
                           lineBreakMode:NSLineBreakByTruncatingMiddle
                           numberOfLines:1
                         backgroundColor:[UIColor clearColor]];
    [self addSubview:_titleLabel];
    
    
    button = [[UIButton alloc] init];
    button.normalBackgroundImage = [TBCreateImage(@"navbar_bt_normal.png") resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 6.0, 14.0, 6.0)];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.exclusiveTouch = YES;
    button.hidden = YES;
    [self addSubview:button];
    _rightButton = button;
    
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  _backButton.frame = CGRectMake(5.0, 7.0, 50.0, 30.0);
  _leftButton.frame = CGRectMake(5.0, 7.0, 50.0, 30.0);
  _titleLabel.frame = CGRectMake(60.0, 2.0, 200.0, 40.0);
  _rightButton.frame = CGRectMake(265.0, 7.0, 50.0, 30.0);
  
}

- (CGSize)sizeThatFits:(CGSize)size
{
  return CGSizeMake(320.0, 44.0);
}



- (void)showBackButton
{
  _backButton.hidden = NO;
  _leftButton.hidden = YES;
}

- (void)showLeftButton
{
  _leftButton.hidden = NO;
  _backButton.hidden = YES;
}

- (void)showRightButton
{
  _rightButton.hidden = NO;
}

@end
