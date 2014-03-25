//
//  TBActionSheet.h
//  Teemo
//
//  Created by Wu Kevin on 3/12/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TBActionSheetBlock)(void);


@interface TBActionSheet : UIActionSheet<
    UIActionSheetDelegate
> {
  
  NSMutableDictionary *_blockDictionary;
  
}

- (id)initWithTitle:(NSString *)title;

- (NSInteger)addButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block;
- (NSInteger)addCancelButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block;
- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title block:(TBActionSheetBlock)block;

@end
