//
//  UILabelExtentions.m
//  Teemo
//
//  Created by Wu Kevin on 9/4/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "UILabelExtentions.h"

@implementation UILabel (Extentions)

+ (id)labelWithFont:(UIFont *)font
          textColor:(UIColor *)textColor
      textAlignment:(NSTextAlignment)textAlignment
      lineBreakMode:(NSLineBreakMode)lineBreakMode
      numberOfLines:(NSInteger)numberOfLines
    backgroundColor:(UIColor *)backgroundColor
{
  UILabel *label = [[UILabel alloc] init];
  label.font = font;
  label.textColor = textColor;
  label.textAlignment = textAlignment;
  label.lineBreakMode = lineBreakMode;
  label.numberOfLines = (numberOfLines<=0) ? 0 : numberOfLines;
  label.backgroundColor = (backgroundColor==nil) ? [UIColor clearColor] : backgroundColor;
  label.adjustsFontSizeToFitWidth = NO;
  return label;
}

@end
