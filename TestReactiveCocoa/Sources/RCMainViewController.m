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
  
  _textField = [[UITextField alloc] init];
  _textField.borderStyle = UITextBorderStyleLine;
  [self.view addSubview:_textField];
  
  _textField.frame = CGRectMake(10.0, 74.0, 300.0, 40.0);
  
  
  [_textField.rac_textSignal subscribeNext:^(id x) {
    NSLog(@"%@", x);
  }];
  
}


@end
