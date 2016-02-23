//
//  SnakeView.m
//  Snake
//
//  Created by wjl-mac1 on 16/2/19.
//  Copyright © 2016年 east. All rights reserved.
//

#import "SnakeView.h"
#import "CellPoint.h"

@interface SnakeView () {
    NSTimer *timer; // 定时器
    NSMutableArray *snakeData;  // 贪吃蛇数据
    CellPoint *foodPos; // 食物位置
}

@end

@implementation SnakeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellSize = 20;
        _cellRow = 22;
        _cellColumn = 15;
        
        [self startGame];
    }
    
    return self;
}

- (void)startGame {
    snakeData = [[NSMutableArray alloc] initWithObjects:
                 [[CellPoint alloc] initWithX:_cellColumn/2 andY:0],
                 [[CellPoint alloc] initWithX:_cellColumn/2 andY:1],
                 [[CellPoint alloc] initWithX:_cellColumn/2 andY:2],
                 [[CellPoint alloc] initWithX:_cellColumn/2 andY:3],
                 nil];
    _orientaion = kDown;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

// 贪吃蛇移动
- (void)move {
    CellPoint *first = [snakeData objectAtIndex:snakeData.count - 1];
    CellPoint *head = [[CellPoint alloc] initWithX:first.x andY:first.y];
    switch (_orientaion) {
        case kUp:
        {
            head.y = head.y - 1;
        }
            break;
        case kDown:
        {
            head.y = head.y + 1;
        }
            break;
        case kLeft:
        {
            head.x = head.x - 1;
        }
            break;
        case kRight:
        {
            head.x = head.x + 1;
        }
            break;
        default:
            break;
    }
    
    if (head.x < 0 || head.x >= _cellColumn || head.y < 0 || head.y >= _cellRow || [snakeData containsObject:head]) {
        [self gameOver];
    } else if ([head isEqual:foodPos]) { // 吃到食物
        [snakeData addObject:head];
        foodPos = nil;
    } else {
        [snakeData addObject:head];
        [snakeData removeObjectAtIndex:0];
    }
    
    [self generateFoodPosition];
    [self setNeedsDisplay];
}

// 生成食物坐标
- (void)generateFoodPosition {
    if (foodPos != nil) {
        return;
    }
    
    while (true) {
        CellPoint *newPos = [[CellPoint alloc] initWithX: arc4random()%_cellColumn andY:arc4random()%_cellRow];
        if (![snakeData containsObject:newPos]) {
            foodPos = newPos;
            break;
        }
    }
}

// 游戏结束
- (void)gameOver {
    [timer invalidate];
    timer = nil;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"游戏结束" message:@"再来一局?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startGame];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)drawHeadInRect:(CGRect)rect context:(CGContextRef)ctx {
     CGContextFillEllipseInRect(ctx, rect);
}

- (void)drawFoodWithContext:(CGContextRef)ctx {
    CGContextClearRect(ctx, CGRectMake(foodPos.x * _cellSize, foodPos.y * _cellSize, _cellSize, _cellSize));
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(foodPos.x * _cellSize, foodPos.y * _cellSize, _cellSize, _cellSize));
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, CGRectMake(0, 0, _cellColumn * _cellSize, _cellRow * _cellSize));
    CGContextSetFillColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, _cellColumn * _cellSize, _cellRow * _cellSize));
    CGContextSetRGBFillColor(ctx, 1, 1, 0, 1);
    for (int i = 0; i<snakeData.count; i++) {
        CellPoint *cp = [snakeData objectAtIndex:i];
        CGRect rect = CGRectMake(cp.x * _cellSize , cp.y * _cellSize
                                 , _cellSize , _cellSize);
        // 绘制蛇尾巴，让蛇的尾巴小一些
        if(i < 4)
        {
            CGFloat inset =  (4 - i);
            CGContextFillEllipseInRect(ctx,CGRectInset(rect, inset, inset));
        }
        // 如果是最后一个元素，代表蛇头，绘制蛇头
        else if (i == snakeData.count - 1)
        {
            [self drawHeadInRect:rect context:ctx];
        }
        else
        {
            CGContextFillEllipseInRect(ctx, rect);
        }
    }
    
    [self drawFoodWithContext:ctx];
}

@end
