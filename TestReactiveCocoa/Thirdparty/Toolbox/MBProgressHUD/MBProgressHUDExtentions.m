//
//  MBProgressHUDExtentions.m
//  Teemo
//
//  Created by Wu Kevin on 3/18/14.
//  Copyright (c) 2014 xbcx. All rights reserved.
//

#import "MBProgressHUDExtentions.h"


@implementation MBProgressHUD (Extentions)

+ (MBProgressHUD *)showHUD:(UIView *)boxView
                      info:(NSString *)info
{
  MBProgressHUD *hud = [MBProgressHUD HUDForView:boxView];
  
  if ( hud==nil ) {
    hud = [[MBProgressHUD alloc] initWithView:boxView];
    [boxView addSubview:hud];
  }
  
  hud.labelText = info;
  hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
  
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.animationType = MBProgressHUDAnimationFade;
  hud.removeFromSuperViewOnHide = YES;
  hud.square = YES;
  hud.dimBackground = NO;
  hud.taskInProgress = YES;
  hud.graceTime = 0.0;
  hud.minShowTime = 1.0;
  
  hud.color = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.9];
  hud.yOffset = (0.5 - 0.618) * boxView.height;
  
  [hud show:YES];
  
  return hud;
}

+ (MBProgressHUD *)showAndHideHUD:(UIView *)boxView
                             info:(NSString *)info
                 createIfNonexist:(BOOL)createIfNonexist
                  completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
  MBProgressHUD *hud = [MBProgressHUD HUDForView:boxView];
  
  if ( hud==nil ) {
    if ( createIfNonexist ) {
      hud = [[MBProgressHUD alloc] initWithView:boxView];
      [boxView addSubview:hud];
    } else {
      return nil;
    }
  } else {
    if ( hud.mode != MBProgressHUDModeIndeterminate ) {
      [hud removeFromSuperview];
      hud = [[MBProgressHUD alloc] initWithView:boxView];
      [boxView addSubview:hud];
    }
  }
  
  hud.labelText = info;
  hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
  
  hud.mode = MBProgressHUDModeIndeterminate;
  hud.animationType = MBProgressHUDAnimationFade;
  hud.removeFromSuperViewOnHide = YES;
  hud.square = YES;
  hud.dimBackground = NO;
  hud.taskInProgress = YES;
  hud.graceTime = 0.0;
  hud.minShowTime = 1.0;
  
  hud.color = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.9];
  hud.yOffset = (0.5 - 0.618) * boxView.height;
  
  [hud show:YES];
  
  hud.completionBlock = completionBlock;
  [hud hide:YES afterDelay:1.0];
  
  return hud;
}

+ (MBProgressHUD *)showTextHUD:(UIView *)boxView
                          info:(NSString *)info
               completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
  MBProgressHUD *hud = [MBProgressHUD HUDForView:boxView];
  
  if ( hud==nil ) {
    hud = [[MBProgressHUD alloc] initWithView:boxView];
    [boxView addSubview:hud];
  } else {
    if ( hud.mode != MBProgressHUDModeText ) {
      [hud removeFromSuperview];
      hud = [[MBProgressHUD alloc] initWithView:boxView];
      [boxView addSubview:hud];
    }
  }
  
  hud.detailsLabelText = info;
  
  hud.mode = MBProgressHUDModeText;
  hud.animationType = MBProgressHUDAnimationFade;
  hud.removeFromSuperViewOnHide = YES;
  hud.square = NO;
  hud.dimBackground = NO;
  hud.taskInProgress = YES;
  hud.graceTime = 0.0;
  hud.minShowTime = 2.0;
  
  hud.color = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.9];
  
  [hud show:YES];
  
  hud.completionBlock = completionBlock;
  [hud hide:YES afterDelay:2.0];
  
  return hud;
}

+ (void)hideHUD:(UIView *)boxView
    immediately:(BOOL)immediately
completionBlock:(MBProgressHUDCompletionBlock)completionBlock
{
  MBProgressHUD *hud = [MBProgressHUD HUDForView:boxView];
  if ( immediately ) {
    [hud removeFromSuperview];
    if ( completionBlock ) {
      completionBlock();
    }
  } else {
    hud.completionBlock = completionBlock;
    [hud hide:YES];
  }
}

@end

