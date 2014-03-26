//
//  RCMainViewController.m
//  TestReactiveCocoa
//
//  Created by Wu Kevin on 3/25/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import "RCMainViewController.h"


@implementation RCMainViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _nameField = [[UITextField alloc] init];
  [_nameField showBorderWithBlueColor];
  _nameField.frame = CGRectMake(10.0, 74.0, 300.0, 40.0);
  [self.view addSubview:_nameField];
  
  _codeField = [[UITextField alloc] init];
  [_codeField showBorderWithBlueColor];
  _codeField.frame = CGRectMake(10.0, 124.0, 300.0, 40.0);
  [self.view addSubview:_codeField];
  
  _button = [[UIButton alloc] init];
  [_button showBorderWithBlueColor];
  [_button addTarget:self action:@selector(doit:) forControlEvents:UIControlEventTouchUpInside];
  _button.frame = CGRectMake(10.0, 174.0, 300.0, 40.0);
  [self.view addSubview:_button];
  
  RAC(_button, enabled) = [RACSignal combineLatest:@[_nameField.rac_textSignal,
                                                     _codeField.rac_textSignal]
                                            reduce:^id(NSString *name, NSString *code) {
                                              return @( ([name length]>0) && ([code length]>0) );
                                            }];
  
}

- (void)doit:(id)sender
{
  TKPRINTMETHOD();
}


@end
