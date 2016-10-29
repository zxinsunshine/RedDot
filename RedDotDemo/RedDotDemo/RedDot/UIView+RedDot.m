//
//  UIView+RedDot.m
//  团购HD
//
//  Created by 周潇 on 2016/10/28.
//  Copyright © 2016年. All rights reserved.
//

#import "UIView+RedDot.h"
#import <objc/runtime.h>
#import "RedDotManager.h"

// 存储一系列路径标签的仓库属性名
const void * pathTagStorageName = "pathTagStorage";

// 小红点名
const void * redDotName = "redDot";

// 小红点名
const void * activeCountName = "activeCount";

// 小红点宽度名
const void * redDotWidthName = "redDotWidth";

// 小红点位置名
const void * redDotPositionName = "redDotPosition";


@interface UIView ()

@property(nonatomic,strong)CALayer * redDot;


@end

@implementation UIView(RedDot)

#pragma mark - 分类属性读写

/**
 获取路径标签集合
 */
- (NSMutableDictionary<NSString *, id> *)getPathTags{
    // {路径名：是否被激活}
    NSMutableDictionary<NSString *,id> * pathTags = objc_getAssociatedObject(self, pathTagStorageName);
    if (!pathTags) {
        pathTags = [[NSMutableDictionary alloc] init];
    }
    return pathTags;
}

/**
 设置路径标签集合
 */
- (void)setPathTags:(NSMutableDictionary<NSString *, id> *)pathTags{
    objc_setAssociatedObject(self, pathTagStorageName, pathTags, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 设置小红点宽度
 */
- (void)setRedDotWidth:(CGFloat)width{
    objc_setAssociatedObject(self, redDotWidthName, @(width), OBJC_ASSOCIATION_ASSIGN);
}

/**
 获取小红点宽度
 */
- (CGFloat)redDotWidth{
    CGFloat width = [objc_getAssociatedObject(self, redDotWidthName) floatValue];
    
    return width<=0?defaultDotWidth:width;
}

/**
 设置小红点位置
 */
- (void)setRedDotPosition:(RedDotPosition)redDotPosition{
    
    objc_setAssociatedObject(self, redDotPositionName, @(redDotPosition), OBJC_ASSOCIATION_ASSIGN);
}

/**
 获取小红点位置
 */
- (RedDotPosition)redDotPosition{
    RedDotPosition position = [objc_getAssociatedObject(self, redDotPositionName) integerValue];
    return position?position:defaultDotPosition;
}

// 小红点
- (CALayer *)redDot{
    
    CALayer * _redDot = objc_getAssociatedObject(self, redDotName);
    
    if (!_redDot) {
        CGSize viewSize = self.bounds.size;
        _redDot = [[CALayer alloc] init];
        _redDot.backgroundColor = [UIColor redColor].CGColor;
        
        CGFloat wid = self.redDotWidth;
        
        switch (self.redDotPosition) {
                
            case RedDotPositionLeft:
                
                _redDot.frame = CGRectMake(-wid, viewSize.height / 2 - wid / 2, wid, wid);
                
                break;
            case RedDotPositionRight:
                
                _redDot.frame = CGRectMake(viewSize.width,  viewSize.height / 2 - wid / 2, wid, wid);
                
                break;
            case RedDotPositionTop:
                
                _redDot.frame = CGRectMake(viewSize.width / 2 - wid / 2 , -wid, wid, wid);
                
                break;
            case RedDotPositionBottom:
                
                _redDot.frame = CGRectMake(viewSize.width / 2 - wid / 2, viewSize.height, wid, wid);
                
                break;
                
            case RedDotPositionCenter:
                
                _redDot.frame = CGRectMake(viewSize.width / 2 - wid / 2, viewSize.height / 2 - wid / 2, wid, wid);
                
                break;
            case RedDotPositionLeftTop:
                
                _redDot.frame = CGRectMake(-wid, -wid, wid, wid);
                
                break;
            case RedDotPositionRightTop:
                
                _redDot.frame = CGRectMake(viewSize.width, 0, wid, wid);
                
                break;
            case RedDotPositionLeftBottom:
                
                _redDot.frame = CGRectMake(0, viewSize.height, wid, wid);
                
                break;
            case RedDotPositionRightBottom:
                
                _redDot.frame = CGRectMake(viewSize.width, viewSize.height, wid, wid);
                
                break;
                
            default:
                
                _redDot.frame = CGRectMake(viewSize.width, 0, wid, wid);
                
                break;
        }
        
        _redDot.cornerRadius = wid / 2;
        [self.layer addSublayer:_redDot];
        _redDot.hidden = YES;
        objc_setAssociatedObject(self, redDotName, _redDot, OBJC_ASSOCIATION_ASSIGN);
    }
    
    return _redDot;
}


#pragma mark - 标签设置
/**
 添加红点路径标签
 */

- (void)addPathTag:(NSString *)tag activated:(BOOL)activated{
    
    // {路径名：是否被激活}
    NSMutableDictionary<NSString *,id> * pathTags = [self getPathTags];
    
    // 没有监听，则加入监听
    if (![[pathTags allKeys] containsObject:tag]) {
        [self addObserverWithTag:tag];
    }
    [pathTags setObject:@(activated) forKey:tag];
    
    // 更新pathTags
    [self setPathTags:pathTags];
    
    // 判断注册时是否需要显示小红点
    self.redDot.hidden = ![self shouldShowRedDot];
    
    
    
    
    
    
}

/**
 
 根据路径激活个数判断是否应该显示小红点
 */
- (BOOL)shouldShowRedDot{
    
    // {路径名：是否被激活}
    NSMutableDictionary<NSString *,id> * pathTags = [self getPathTags];
    
    NSLog(@"%@%@",self,pathTags);
    
    __block BOOL shouldActive = NO;
    
    // 如果至少有一条路径被激活，则应该显示小红点
    [pathTags enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj boolValue]) {
            shouldActive = YES;
            *stop = YES;
        }
        
    }];
    
    NSLog(@"shouldShow:%@",@(shouldActive));
    NSLog(@"-----------------------------------");
    return shouldActive;
}

/**
 移除红点路径标签或路径终点标签
 */

- (void)removePathTag:(NSString *)tag{
    
    NSMutableDictionary<NSString *, id> * pathTags = [self getPathTags];
    [pathTags removeObjectForKey:tag];
    
    [self setPathTags:pathTags];
    
    [self removeObserverWithTag:tag];
}

/**
 是否有红点路径标签
 */

- (BOOL)hasPathTag:(NSString *)tag{
    NSMutableDictionary<NSString *, id> * pathTags = [self getPathTags];
    
    return [[pathTags allKeys] containsObject:tag];
}



#pragma mark - 监听设置
// 添加监听
- (void)addObserverWithTag:(NSString *)tag{
    
    if (tag) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRedDot:) name:[NSString stringWithFormat:@"%@%@",RedDotNotifationPrefix,tag] object:nil];
    }
    
}

// 是否显示红点
- (void)showRedDot:(NSNotification *)noti{
    
    // 标签名
    NSString * tagName = [noti.name substringFromIndex:RedDotNotifationPrefix.length];
    NSLog(@"noti------%@",tagName);
    
    NSMutableDictionary<NSString *, id> * pathTags = [self getPathTags];
    [pathTags setObject:noti.object forKey:tagName];
    
    [self setPathTags:pathTags];
    
    // 判断是否需要显示小红点
    self.redDot.hidden = ![self shouldShowRedDot];
}

// 移除监听
- (void)removeObserverWithTag:(NSString *)tag{
    if (tag) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@%@",RedDotNotifationPrefix,tag] object:nil];
    }
}

- (void)dealloc{
    // 移除所有监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 解除路径注册
    NSMutableDictionary<NSString *,id> * pathTags = objc_getAssociatedObject(self, pathTagStorageName);
    
    [[pathTags allKeys] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [[RedDotManager sharedManager] quitRegisterView:self withPathTag:obj];
    }];
    
  
}





@end
