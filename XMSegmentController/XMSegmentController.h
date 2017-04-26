//
//  XMSegmentController.h
//  SegmentController
//
//  Created by Justming on 2017/4/25.
//  Copyright © 2017年 Justming. All rights reserved.
//
//

#import <UIKit/UIKit.h>
@class XMSegmentController;

@protocol XMSegmentControllerDelegate <NSObject>

@optional
- (void)segmentController:(XMSegmentController *)segmentController didSelectItemAtIndex:(NSInteger)index;

@end

@interface XMSegmentController : UIViewController

/**
 标签高度，默认35
 */
@property (nonatomic, assign) CGFloat buttonHeight;

/**
 标签宽度，默认1/4全屏宽
 */
@property (nonatomic, assign) CGFloat buttonWidth;

/**
 标签正常颜色，默认黑色
 */
@property (nonatomic, strong) UIColor * buttonColor;

/**
 标签选中颜色，默认红色
 */
@property (nonatomic, strong) UIColor * buttonSelectedColor;
/**
 标签名字体大小，默认16
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 标签下划线宽度,默认为self.buttonWidth-40
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 标签下划线高度，默认为2.0
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 标签下划线颜色，默认红色
 */
@property (nonatomic, strong) UIColor * lineColor;


@property (nonatomic, weak) id <XMSegmentControllerDelegate> delegate;


/**
 初始化内容,如需自定制属性请使用此方法

 @param titleArray 标题数组
 @param viewControllers 子控制器数组
 */
- (void)initSegmentWithTitleArray:(NSArray *)titleArray subViewControllers:(NSArray *)viewControllers;


/**
 把菜单控制器添加到没有导航栏的父控制器中
 
 @param parentController 不带导航栏的父控制器
 */
- (void)addToParentControllerNoNavigationBar:(UIViewController *)parentController;

/**
 把菜单控制器添加到带导航栏的父控制器中

 @param parentController 带导航栏的父控制器
 */
- (void)addToParentControllerWithNavigationBar:(UIViewController *)parentController;





@end

