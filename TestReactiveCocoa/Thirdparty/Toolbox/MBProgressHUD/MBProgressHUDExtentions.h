//
//  MBProgressHUDExtentions.h
//  Teemo
//
//  Created by Wu Kevin on 3/18/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBProgressHUD (Extentions)

+ (MBProgressHUD *)showHUD:(UIView *)boxView
                      info:(NSString *)info;

+ (MBProgressHUD *)showAndHideHUD:(UIView *)boxView
                             info:(NSString *)info
                 createIfNonexist:(BOOL)createIfNonexist
                  completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

+ (MBProgressHUD *)showTextHUD:(UIView *)boxView
                          info:(NSString *)info
               completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

+ (void)hideHUD:(UIView *)boxView
    immediately:(BOOL)immediately
completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

@end
