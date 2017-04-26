# XMSegmentController



## 使用方法
    使用步骤：
    1.创建对象
    XMSegmentController * segment = [[XMSegmentController alloc] init];
 
    2.设置属性
    segment.buttonWidth = SCREEN_WIDTH / 5;
    segment.buttonColor = [UIColor blueColor];
 
    3.初始化控制器
    [segment initSegmentWithTitleArray:titleArray subViewControllers:array];
 
    4.添加到父控制器
    (1)父控制器没有导航栏
    [segment addToParentControllerNoNavigationBar:self];
    (2)父控制器有导航栏
    [segment addToParentControllerWithNavigationBar:self];
    
    5.如需响应点击事件，设置代理并实现代理方法
    segment.delegate = self;
    

    
# 效果图 

### 无导航栏

![](https://github.com/Justming/XMSegmentController/raw/master/1.gif)

### 有导航栏

![](https://github.com/Justming/XMSegmentController/raw/master/2.gif)
