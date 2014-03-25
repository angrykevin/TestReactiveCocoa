//
//  TBCommon.m
//  Teemo
//
//  Created by Wu Kevin on 12/19/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "TBCommon.h"


UIImage *TBCreateImage(NSString *name)
{
  NSString *path = TKPathForBundleResource(nil, name);
  return [[UIImage alloc] initWithContentsOfFile:path];
}

UIImage *TBCachedImage(NSString *name)
{
  return [UIImage imageNamed:name];
}


void TBPresentMessage(NSString *message)
{
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                            otherButtonTitles:nil];
  [alertView show];
}


NSString *TBFormatDate(NSDate *date)
{
  if ( date ) {
    
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [now timeIntervalSinceDate:date];
    
    if ( timeInterval <= 5.0 ) {
      return NSLocalizedString(@"刚刚", @"");
    } else if ( timeInterval < 30.0 ) {
      NSString *fmt = NSLocalizedString(@"%d秒前", @"");
      return [NSString stringWithFormat:fmt, (int)(timeInterval)];
    } else if ( timeInterval < 60.0 ) {
      return NSLocalizedString(@"半分钟前", @"");
    } else if ( timeInterval < 30 * 60.0 ) {
      NSString *fmt = NSLocalizedString(@"%d分钟前", @"");
      return [NSString stringWithFormat:fmt, (int)(timeInterval/60.0)];
    } else if ( timeInterval < 60 * 60.0 ) {
      return NSLocalizedString(@"半小时前", @"");
    } else {
      if ( [now isSameDayAsDate:date] ) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:date];
      } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:date];
      }
    }
    
  }
  return nil;
}


NSString *TBMergeString(NSString *first, NSString *second)
{
  NSMutableString *string = [[NSMutableString alloc] init];
  if ( [first length] > 0 ) {
    [string appendString:first];
    if ( [second length]>0 ) {
      [string appendString:@" "];
      [string appendString:second];
    }
  } else {
    if ( [second length]>0 ) {
      [string appendString:second];
    }
  }
  if ( [string length] > 0 ) {
    return string;
  }
  return nil;
}
