//
//  TBAlertView.m
//  Teemo
//
//  Created by Wu Kevin on 11/15/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBAlertView.h"

@implementation TBAlertView

- (id)initWithMessage:(NSString *)message
{
  self = [super initWithTitle:message
                      message:nil
                     delegate:nil
            cancelButtonTitle:nil
            otherButtonTitles:nil];
  if (self) {
    
    self.delegate = self;
    
    _blockDictionary = [[NSMutableDictionary alloc] init];
    
  }
  return self;
}

- (NSInteger)addButtonWithTitle:(NSString *)title block:(TBAlertViewBlock)block
{
  if ( [title length] > 0 ) {
    
    if ( ![_blockDictionary hasKeyEqualTo:title] ) {
      NSInteger index = [self addButtonWithTitle:title];
      
      if ( block ) {
        [_blockDictionary setObject:[block copy] forKey:title];
      } else {
        [_blockDictionary setObject:[NSNull null] forKey:title];
      }
      
      return index;
    }
    
  }
  
  return -1;
}

- (NSInteger)addCancelButtonWithTitle:(NSString *)title block:(TBAlertViewBlock)block
{
  NSInteger index = [self addButtonWithTitle:title block:block];
  if ( index >= 0 ) {
    [self setCancelButtonIndex:index];
  }
  return index;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  NSString *title = [self buttonTitleAtIndex:buttonIndex];
  id block = [_blockDictionary objectForKey:title];
  if ( block != [NSNull null] ) {
    ((TBAlertViewBlock)block)();
  }
}

@end
