//
//  CellPoint.h
//  Snake
//
//  Created by wjl-mac1 on 16/2/19.
//  Copyright © 2016年 east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellPoint : NSObject

@property (nonatomic, assign) NSInteger x;  // 方格x坐标
@property (nonatomic, assign) NSInteger y;  // 方格y坐标

- (id)initWithX:(NSInteger)x andY:(NSInteger)y;
- (BOOL)isEqual:(id)object;

@end
