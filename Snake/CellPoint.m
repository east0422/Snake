//
//  CellPoint.m
//  Snake
//
//  Created by wjl-mac1 on 16/2/19.
//  Copyright © 2016年 east. All rights reserved.
//

#import "CellPoint.h"

@implementation CellPoint

- (id)initWithX:(NSInteger)x andY:(NSInteger)y {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if ([object isKindOfClass:[CellPoint class]]) {
        CellPoint *other = (CellPoint *)object;
        return (_x == other.x && _y == other.y);
    }
    
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{%d,%d}",self.x,self.y];
}

@end
