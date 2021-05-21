//
//  UIButton+IncreaseHitArea.m
//  VideoDownloader
//
//  Created by Jin Sun on 13-5-15.
//  Copyright (c) 2013年 Jin Sun. All rights reserved.
//

#import "UIButton+IncreaseHitArea.h"
#import <objc/runtime.h>

@implementation UIButton (IncreaseHitArea)

@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"ButtonHitTestEdgeInsets";

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

/// 设置按钮最小点击区域为 44 x 44
//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//
//    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
//    if (frame.size.width < 44.0f) {
//        edgeInsets.left = edgeInsets.right = (frame.size.width -44.0f)/2;
//    }
//    if (frame.size.height < 44.0f) {
//        edgeInsets.top = edgeInsets.bottom = (frame.size.height -44.0f)/2;
//    }
//    self.hitTestEdgeInsets = edgeInsets;
//}

@end
