//
//  TBCommon.h
//  Teemo
//
//  Created by Wu Kevin on 12/19/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef void (^TBOperationCompletionHandler)(id result, NSError *error);

#define TBEllipsisMark @"\u2026"

#define TBRGBAColor(__r, __g, __b, __a) ([UIColor colorWithRed:__r/255.0 green:__g/255.0 blue:__b/255.0 alpha:__a/255.0])
#define TBRGBColor(__r, __g, __b) ([UIColor colorWithRed:__r/255.0 green:__g/255.0 blue:__b/255.0 alpha:1.0])


#ifdef __cplusplus
extern "C" {
#endif


UIImage *TBCreateImage(NSString *name);
UIImage *TBCachedImage(NSString *name);

void TBPresentMessage(NSString *message);

NSString *TBFormatDate(NSDate *date);

NSString *TBMergeString(NSString *first, NSString *second);


#ifdef __cplusplus
}
#endif
