//
//  SubViewController.m
//  SegmentController
//
//  Created by hxm on 2017/4/26.
//  Copyright © 2017年 hxm. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0
                                                green:(arc4random()%256)/255.0
                                                 blue:(arc4random()%256)/255.0
                                                alpha:1];
}



@end
