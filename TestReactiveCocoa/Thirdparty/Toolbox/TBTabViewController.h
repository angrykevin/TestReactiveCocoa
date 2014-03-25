//
//  TBTabViewController.h
//  Teemo
//
//  Created by Wu Kevin on 11/8/13.
//  Copyright (c) 2013 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TBTabView;


@interface TBTabViewController : UIViewController {
  NSArray *_viewControllers;
  TBTabView *_tabView;
  
  BOOL _viewAppeared;
  NSUInteger _appearedTimes;
}

@property (nonatomic, strong, readonly) NSArray *viewControllers;

- (void)layoutViews;

- (void)setupWithItems:(NSArray *)items viewControllers:(NSArray *)viewControllers;

@end





@class TBTabViewItem;

typedef void(^TBTabViewBlock)(NSUInteger index, TBTabViewItem *item);

@interface TBTabView : UIView {
  NSArray *_items;
  
  BOOL _repeatedlyNotify;
  TBTabViewBlock _block;
  NSUInteger _selectedIndex;
}

@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, assign) BOOL repeatedlyNotify;
@property (nonatomic, copy) TBTabViewBlock block;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

- (id)initWithItems:(NSArray *)items;

- (void)selectItemAtIndex:(NSUInteger)index;

@end

@interface TBTabViewItem : NSObject {
  
  UIButton *_button;
  
  NSString *_normalTitle;
  NSString *_highlightedTitle;
  
  UIColor *_normalTitleColor;
  UIColor *_highlightedTitleColor;
  
  UIImage *_normalImage;
  UIImage *_highlightedImage;
  
  UIImage *_normalBackgroundImage;
  UIImage *_highlightedBackgroundImage;
}

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *highlightedTitle;

@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIColor *highlightedTitleColor;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@property (nonatomic, strong) UIImage *normalBackgroundImage;
@property (nonatomic, strong) UIImage *highlightedBackgroundImage;

+ (TBTabViewItem *)itemWithNormalTitle:(NSString *)normalTitle
                      highlightedTitle:(NSString *)highlightedTitle
                      normalTitleColor:(UIColor *)normalTitleColor
                 highlightedTitleColor:(UIColor *)highlightedTitleColor
                           normalImage:(UIImage *)normalImage
                      highlightedImage:(UIImage *)highlightedImage
                 normalBackgroundImage:(UIImage *)normalBackgroundImage
            highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage;

@end
