//
//  TBAlertView.h
//  Teemo
//
//  Created by Wu Kevin on 11/15/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TBAlertViewBlock)(void);


@interface TBAlertView : UIAlertView<
    UIAlertViewDelegate
> {
  
  NSMutableDictionary *_blockDictionary;
  
}

- (id)initWithMessage:(NSString *)message;

- (NSInteger)addButtonWithTitle:(NSString *)title block:(TBAlertViewBlock)block;
- (NSInteger)addCancelButtonWithTitle:(NSString *)title block:(TBAlertViewBlock)block;

@end
