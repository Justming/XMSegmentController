//
//  XMSegmentController.m
//  SegmentController
//
//  Created by hxm on 2017/4/25.
//  Copyright © 2017年 hxm. All rights reserved.
//

#import "XMSegmentController.h"


#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

@interface XMSegmentController ()<UIScrollViewDelegate>

@end

@implementation XMSegmentController
{
    NSMutableArray * _buttonArray;
    UIButton * _selectedButton;
    UIScrollView * _headScroll;
    UIScrollView * _bodyScroll;
    UILabel * _line;
}


- (void)initSegmentWithTitleArray:(NSArray *)titleArray subViewControllers:(NSArray *)viewControllers{
    
    _buttonArray = [NSMutableArray new];
    
    [self addButtonsToScrollHeader:titleArray];
    
    [self addSubViewControllersToScroll:viewControllers];
}
#pragma mark - 添加头部组件(button和下划线)
- (void)addButtonsToScrollHeader:(NSArray *)titleArray{
    
    _headScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.buttonHeight)];
    _headScroll.backgroundColor = [UIColor whiteColor];
    _headScroll.showsHorizontalScrollIndicator = NO;
    _headScroll.showsVerticalScrollIndicator = NO;
    _headScroll.delegate = self;
    _headScroll.bounces = NO;
    [self.view addSubview:_headScroll];
    
    for (int i=0; i<titleArray.count; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i*self.buttonWidth, 0, self.buttonWidth, self.buttonHeight)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:self.buttonColor forState:UIControlStateNormal];
        [button setTitleColor:self.buttonSelectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        button.tag = i;
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.selected = YES;
            _selectedButton = button;
        }
        [_buttonArray addObject:button];
        [_headScroll addSubview:button];
    }
    
    CGFloat margin = (self.buttonWidth - self.lineWidth) / 2;
    _line = [[UILabel alloc] initWithFrame:CGRectMake(margin, self.buttonHeight-self.lineHeight-1, self.lineWidth, self.lineHeight)];
    _line.backgroundColor = self.lineColor;
    [_headScroll addSubview:_line];
    
    _headScroll.contentSize = CGSizeMake(titleArray.count * self.buttonWidth, self.buttonHeight);
}
#pragma mark - 添加子控制器
- (void)addSubViewControllersToScroll:(NSArray *)viewControllers{
    
    _bodyScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.buttonHeight)];
    _bodyScroll.backgroundColor = [UIColor whiteColor];
    _bodyScroll.delegate = self;
    _bodyScroll.pagingEnabled = YES;
    _bodyScroll.bounces = NO;
    _bodyScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_bodyScroll];
    
    for (int i=0; i<viewControllers.count; i++) {
        
        UIViewController * vc = viewControllers[i];
        [self addChildViewController:vc];
        
        vc.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, _bodyScroll.bounds.size.height);
        
        [_bodyScroll addSubview:vc.view];
    }
    _bodyScroll.contentSize = CGSizeMake(SCREEN_WIDTH*viewControllers.count, _bodyScroll.bounds.size.height);
    
}
#pragma mark - 添加到父控制器中
- (void)addToParentControllerNoNavigationBar:(UIViewController *)parentController{
    
    [parentController addChildViewController:self];
    CGRect rect = parentController.view.frame;
    self.view.frame = CGRectMake(0, 20, rect.size.width, rect.size.height-20);
    [parentController.view addSubview:self.view];

}
- (void)addToParentControllerWithNavigationBar:(UIViewController *)parentController{
    [parentController addChildViewController:self];
    CGRect rect = parentController.view.frame;
    self.view.frame = CGRectMake(0, 64, rect.size.width, rect.size.height-64);
    [parentController.view addSubview:self.view];
}
#pragma mark - 点击标签按钮
- (void)buttonSelected:(UIButton *)button{
    
    [self selectButton:button.tag];
    [_bodyScroll setContentOffset:CGPointMake(button.tag*SCREEN_WIDTH, 0) animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(segmentController:didSelectItemAtIndex:)]) {
        [self.delegate segmentController:self didSelectItemAtIndex:button.tag];
    }
    
}
- (void)selectButton:(NSInteger)index{
    //修改按钮颜色
    UIButton * button = _buttonArray[index];
    button.selected = YES;
    if (_selectedButton != button) {
        _selectedButton.selected = NO;
        _selectedButton = button;
    }
    
    //修改下划线位置
    CGFloat margin = (self.buttonWidth - self.lineWidth) / 2;
    CGRect rect = CGRectMake(margin+self.buttonWidth*index, self.buttonHeight-self.lineHeight-1, self.lineWidth, self.lineHeight);
    [UIView animateWithDuration:0.3 animations:^{
        _line.frame = rect;
    }];
    
    //滑动居中
    CGFloat leading = (SCREEN_WIDTH - self.buttonWidth) / 2;
    if (self.buttonWidth * index < leading) {
        [_headScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (_headScroll.contentSize.width - self.buttonWidth*(index+1) < leading) {
        [_headScroll setContentOffset:CGPointMake(_headScroll.contentSize.width-SCREEN_WIDTH, 0) animated:YES];
    }
    else {
        [_headScroll setContentOffset:CGPointMake((self.buttonWidth*index - leading), 0) animated:YES];
    }
}
#pragma mark - scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _bodyScroll) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = offsetX  / SCREEN_WIDTH;
        [self selectButton:index];
    }
}

#pragma mark - getter

- (CGFloat)buttonHeight{
    
    if (!_buttonHeight) {
        return 35;
    }
    return _buttonHeight;
}
- (CGFloat)buttonWidth{
    
    if (!_buttonWidth) {
        return SCREEN_WIDTH / 4;
    }
    return _buttonWidth;
}
- (UIColor *)buttonColor{
    
    if (!_buttonColor) {
        return [UIColor blackColor];
    }
    return _buttonColor;
}
- (UIColor *)buttonSelectedColor{
    
    if (!_buttonSelectedColor) {
        return [UIColor redColor];
    }
    return _buttonSelectedColor;
}
- (CGFloat)fontSize{
    
    if (!_fontSize) {
        return 16;
    }
    return _fontSize;
}
- (CGFloat)lineWidth{
    
    if (!_lineWidth) {
        return self.buttonWidth - 40;
    }
    return _lineWidth;
}
- (CGFloat)lineHeight {
    
    if (!_lineHeight) {
        return 2.0;
    }
    return _lineHeight;
}
- (UIColor *)lineColor {
    
    if (!_lineColor) {
        return [UIColor redColor];
    }
    return _lineColor;
}
@end
