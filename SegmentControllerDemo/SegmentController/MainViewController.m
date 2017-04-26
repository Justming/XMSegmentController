//
//  MainViewController.m
//  SegmentController
//
//  Created by hxm on 2017/4/26.
//  Copyright © 2017年 hxm. All rights reserved.
//

#import "MainViewController.h"
#import "XMSegmentController.h"
#import "SubViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface MainViewController ()<XMSegmentControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"菜单控制器";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray * titleArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"];
    
    NSMutableArray * array = [NSMutableArray new];
    for (int i=0; i<7; i++) {
        SubViewController * sub = [[SubViewController alloc] init];
        [array addObject:sub];
    }
    
    XMSegmentController * segment = [[XMSegmentController alloc] init];
    segment.delegate = self;
    segment.buttonWidth = SCREEN_WIDTH / 5;
    segment.buttonColor = [UIColor blueColor];
    
    
    [segment initSegmentWithTitleArray:titleArray subViewControllers:array];
    [segment addToParentControllerNoNavigationBar:self];
    
}

- (void)segmentController:(XMSegmentController *)segmentController didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"点击了第%ld个", index+1);
}

@end
