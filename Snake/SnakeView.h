//
//  SnakeView.h
//  Snake
//
//  Created by wjl-mac1 on 16/2/19.
//  Copyright © 2016年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kUp,    // 向上
    kDown,  // 向下
    kLeft,  // 向左
    kRight  // 向右
}Orientaion;

@interface SnakeView : UIView

@property (nonatomic, assign) Orientaion orientaion;
@property (nonatomic, assign) CGFloat cellSize;     // 每个方格大小
@property (nonatomic, assign) NSInteger cellRow;    // 列数
@property (nonatomic, assign) NSInteger cellColumn; // 行数

@end
