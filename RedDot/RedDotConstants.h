//
//  RedDotConstants.h
// 红点全局常量设置

#import <UIKit/UIKit.h>

#ifndef RedDotConstants_h
#define RedDotConstants_h


typedef enum : NSUInteger {
    RedDotPositionLeft = 1,
    RedDotPositionRight,
    RedDotPositionTop,
    RedDotPositionBottom,
    RedDotPositionCenter,
    RedDotPositionLeftTop,
    RedDotPositionRightTop,
    RedDotPositionLeftBottom,
    RedDotPositionRightBottom
} RedDotPosition;

// 默认红点大小
static const CGFloat defaultDotWidth = 5;

// 默认红点位置
static const RedDotPosition defaultDotPosition = RedDotPositionRightTop;

// 默认终点后缀
static const NSString * const destinationSuffix = @"_destination";

// 激活小红点通知名前缀
static const NSString * const RedDotNotifationPrefix = @"RedDotNotifation_";

#endif /* RedDotConstants_h */
