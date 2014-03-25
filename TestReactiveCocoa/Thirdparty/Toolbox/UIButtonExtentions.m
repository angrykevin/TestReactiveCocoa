//
//  UIButtonExtentions.m
//  Teemo
//
//  Created by Wu Kevin on 12/2/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import "UIButtonExtentions.h"

@implementation UIButton (Extentions)

- (void)centerContent:(CGFloat)spacing
{
  CGSize imageSize = self.imageView.frame.size;
  CGSize titleSize = [self.titleLabel sizeThatFits:self.bounds.size];
  self.imageEdgeInsets = UIEdgeInsetsMake(0.0 - (titleSize.height + spacing), 0.0, 0.0, 0.0 - titleSize.width);
  self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0 - imageSize.width, 0.0 - (imageSize.height + spacing), 0.0);
}

@end
