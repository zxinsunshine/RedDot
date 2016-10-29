//
//  UIView+RedDot.h


#import <UIKit/UIKit.h>
#import "RedDotConstants.h"

@interface UIView(RedDot)

/**
  添加红点路径标签
 */

- (void)addPathTag:(NSString *)tag activated:(BOOL)activated;

/**
 移除红点路径标签，包括带有终点后缀的标签
 */

- (void)removePathTag:(NSString *)tag;

/**
 是否有红点路径标签，包括带有终点后缀的标签
 */

- (BOOL)hasPathTag:(NSString *)tag;




/*
  设置红点大小
 **/
@property(nonatomic,assign)CGFloat redDotWidth;

/*
 设置红点位置
 **/
@property(nonatomic,assign)RedDotPosition redDotPosition;


@end
