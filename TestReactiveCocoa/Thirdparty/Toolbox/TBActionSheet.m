//
//  TBActionSheet.m
//  Teemo
//
//  Created by Wu Kevin on 3/12/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import "TBActionSheet.h"

@implementation TBActionSheet

- (id)initWithTitle:(NSString *)title
{
  self = [super initWithTitle:title
                     delegate:nil
            cancelButtonTitle:nil
       destructiveButtonTitle:nil
            otherButtonTitles:nil];
  if (self) {
    
    self.delegate = self;
    
    _blockDictionary = [[NSMutableDictionary alloc] init];
    
  }
  return self;
}


- (NSInteger)addButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block
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

- (NSInteger)addCancelButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block
{
  NSInteger index = [self addButtonWithTitle:title block:block];
  if ( index >= 0 ) {
    [self setCancelButtonIndex:index];
  }
  return index;
}

- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block
{
  NSInteger index = [self addButtonWithTitle:title block:block];
  if ( index >= 0 ) {
    [self setDestructiveButtonIndex:index];
  }
  return index;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  NSString *title = [self buttonTitleAtIndex:buttonIndex];
  id block = [_blockDictionary objectForKey:title];
  if ( block != [NSNull null] ) {
    ((TBActionSheetBlock)block)();
  }
}

@end
