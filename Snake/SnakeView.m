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
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:YES];
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
