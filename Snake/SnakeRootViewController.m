//
//  SnakeRootViewController.m
//  Snake
//
//  Created by fangdong on 15/12/22.
//  Copyright © 2015年 east. All rights reserved.
//

#import "SnakeRootViewController.h"
#import "SnakeView.h"

@interface SnakeRootViewController () {
    SnakeView *snakeView;
}

@end

@implementation SnakeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    snakeView = [[SnakeView alloc] initWithFrame:CGRectMake(10, 30, 15 * 20, 22 * 20)];
    // 为snakeView控件设置边框和圆角。
    snakeView.layer.borderWidth = 3;
    snakeView.layer.borderColor = [[UIColor redColor] CGColor];
    snakeView.layer.cornerRadius = 6;
    snakeView.layer.masksToBounds = YES;
    // 设置self.view控件支持用户交互
    self.view.userInteractionEnabled = YES;
    // 设置self.view控件支持多点触碰
    self.view.multipleTouchEnabled = YES;
    for (int i = 0 ; i < 4 ; i++)
    {
        // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleSwipe:)];
        // 设置该点击手势处理器只处理i个手指的轻扫手势
        gesture.numberOfTouchesRequired = 1;
        // 指定该手势处理器只处理1 << i方向的轻扫手势
        gesture.direction = 1 << i;
        // 为self.view控件添加手势处理器。
        [self.view addGestureRecognizer:gesture];
    }
    
    [self.view addSubview:snakeView];
}

// 实现手势处理器的方法，该方法应该声明一个形参。
// 当该方法被激发时，手势处理器会作为参数传给该方法的参数。
- (void) handleSwipe:(UISwipeGestureRecognizer*)gesture
{
    // 获取轻扫手势的方向
    NSUInteger direction = gesture.direction;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if(snakeView.orientaion != kRight) // 只要不是向右，即可改变方向
                snakeView.orientaion = kLeft;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if(snakeView.orientaion != kDown) // 只要不是向下，即可改变方向
                snakeView.orientaion = kUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if(snakeView.orientaion != kUp) // 只要不是向上，即可改变方向
                snakeView.orientaion = kDown;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if(snakeView.orientaion != kLeft) // 只要不是向左，即可改变方向
                snakeView.orientaion = kRight;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
