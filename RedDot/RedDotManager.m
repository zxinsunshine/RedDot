//
//  RedDotManager.m
//  团购HD
//
//  Created by 周潇 on 2016/10/28.
//  Copyright © 2016年 王志盼. All rights reserved.
//

#import "RedDotManager.h"
#import "UIView+RedDot.h"
#import "RedDotPathInfo.h"


@interface RedDotManager ()

// 路径缓存，{路径名：路径信息}
@property(nonatomic,strong)NSMutableDictionary<NSString *, RedDotPathInfo *> * pathStorage;

@end

@implementation RedDotManager



/**
 小红点管理者单例
 */
+ (instancetype)sharedManager{
    static RedDotManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
            instance.pathStorage = [[NSMutableDictionary alloc] init];
        }
    });
    return instance;
}

#pragma mark - 注册UIView
/**
 注册视图，指定路径名
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag{
    
    [self registerView:view withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:defaultDotPosition];
}

/**
 注册视图，指定路径名和红点大小
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth{
    [self registerView:view withPathTag:tag andDotWidth:dotWidth andDotPosition:defaultDotPosition];
}

/**
 注册视图，指定路径名、当前视图的红点位置
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition{
    [self registerView:view withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:dotPosition];
}

/**
 - 注册视图，指定路径名、当前视图的红点大小、红点位置、是否为终点
 - （最终的设定方法）
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition{
    
    RedDotPathInfo * pathInfo = nil;
    // 没有注册过路径，添加缓存路径信息
    if (![[_pathStorage allKeys] containsObject:tag]) {
        pathInfo = [[RedDotPathInfo alloc] initWithName:tag andPointNumber:1];
        [_pathStorage setObject:pathInfo forKey:tag];
    }
    else{
        pathInfo = [_pathStorage objectForKey:tag];
        pathInfo.pointNumber = pathInfo.pointNumber + 1; // 节点+1
        
    }
    
    
    // 设置红点大小和位置信息
    view.redDotWidth = dotWidth;
    view.redDotPosition = dotPosition;
    
    [view addPathTag:tag activated:pathInfo.isActive];
    
    
}


/**
 取消注册
 */
- (void)quitRegisterView:(UIView *)view withPathTag:(NSString *)tag{
    
    // 先判断是否有标签，避免重复取消
    if ([view hasPathTag:tag]) {
        
        // 缓存注册信息表更新
        RedDotPathInfo * pathInfo = [_pathStorage objectForKey:tag];
        if (pathInfo) {
            pathInfo.pointNumber = pathInfo.pointNumber - 1;
            
            // 没有节点了，删除路径
            if (pathInfo.pointNumber <= 0) {
                [_pathStorage removeObjectForKey:tag];
            }

            
        }
        
        // 当前视图删除注册标签
        [view removePathTag:tag];
        
    }
    
}


#pragma mark - 注册TabBar

/**
 注册TabBar的第i个图标（0~N-1），指定路径名
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag{
    
    [self registerTabBar:tabBar atIndex:tabIdx withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:defaultDotPosition];
    
}


/**
 注册TabBar的第i个图标（0~N-1），指定路径名和红点大小
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth{
    [self registerTabBar:tabBar atIndex:tabIdx withPathTag:tag andDotWidth:dotWidth andDotPosition:defaultDotPosition];
}


/**
 注册TabBar的第i个图标（0~N-1），指定路径名、当前视图的红点位置
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition{
    [self registerTabBar:tabBar atIndex:tabIdx withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:dotPosition];
}

/**
 注册TabBar的第i个图标（0~N-1），指定路径名、当前视图的红点大小、红点位置、是否为终点
 - （最终的设定方法）
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition{
    
    // 如果参数是UITabBar实例或子类 且 指定坐标小于tabBarItems个数
    if ([tabBar isKindOfClass:[UITabBar class]] && tabIdx < tabBar.items.count) {
        
        __block NSInteger countIdx = -1;
        
        [tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString * classStr = NSStringFromClass(obj.class);
            if ([classStr isEqualToString:@"UITabBarButton"] ) {
                countIdx += 1;
                if (countIdx == tabIdx) {
                    
                    [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        NSString * subClassStr = NSStringFromClass(obj.class);
                        if ([subClassStr isEqualToString:@"UITabBarSwappableImageView"]) {
                            [self registerView:obj withPathTag:@"g" andDotWidth:dotWidth andDotPosition:dotPosition];
                            *stop = YES;
                            
                        }
                    }];
                    
                    *stop = YES;
                }
                
            }
            
        }];
    }
}

/**
 取消注册TabBar的第i个图标（0~N-1）
 */
- (void)quitRegisterTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag{
    
    // 如果参数是UITabBar实例或子类 且 指定坐标小于tabBarItems个数
    if ([tabBar isKindOfClass:[UITabBar class]] && tabIdx < tabBar.items.count) {
        
        __block NSInteger countIdx = -1;
        
        [tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString * classStr = NSStringFromClass(obj.class);
            if ([classStr isEqualToString:@"UITabBarButton"] ) {
                countIdx += 1;
                if (countIdx == tabIdx) {
                    
                    [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        NSString * subClassStr = NSStringFromClass(obj.class);
                        if ([subClassStr isEqualToString:@"UITabBarSwappableImageView"]) {
                            
                            [self quitRegisterView:obj withPathTag:tag];
                            
                            *stop = YES;
                            
                        }
                    }];
                    
                    *stop = YES;
                }
                
            }
            
        }];
    }
    
}


#pragma mark - 注册NavigationBar
/**
 * 注册NavigationBar的第i个图标（从左往右数），指定路径名；
 * 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag{
    [self registerNavigationBar:navigationBar atIndex:naviBarIdx withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:defaultDotPosition];
}

/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名和红点大小；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag  andDotWidth:(CGFloat)dotWidth{
    [self registerNavigationBar:navigationBar atIndex:naviBarIdx withPathTag:tag andDotWidth:dotWidth andDotPosition:defaultDotPosition];
}


/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名、当前视图的红点位置；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition{
    [self registerNavigationBar:navigationBar atIndex:naviBarIdx withPathTag:tag andDotWidth:defaultDotWidth andDotPosition:dotPosition];
}

/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名、当前视图的红点大小、红点位置、是否为终点；
 注意：左边边从左往右数，右边从右往左数
 - （最终的设定方法）
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition{
    
    if ([navigationBar isKindOfClass:[UINavigationBar class]]) {
        
        __block NSInteger countIdx = -1;
        
        [navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            NSString * classStr = NSStringFromClass(obj.class);
            if ([classStr isEqualToString:@"UINavigationButton"]) {
                countIdx += 1;
                
                if (countIdx == naviBarIdx) {
                    
                    [self registerView:obj withPathTag:tag andDotWidth:dotWidth andDotPosition:dotPosition];
                    
                    *stop = YES;
                }
            }     
        }];
    }
    
}

/**
 注册NavigationBar的第i个图标（从左往右数）
 */
- (void)quitRegisterNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag{
    
    if ([navigationBar isKindOfClass:[UINavigationBar class]]) {
        
        __block NSInteger countIdx = -1;
        
        [navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            NSString * classStr = NSStringFromClass(obj.class);
            if ([classStr isEqualToString:@"UINavigationButton"]) {
                countIdx += 1;
                
                if (countIdx == naviBarIdx) {
                    
                    [self quitRegisterView:obj withPathTag:tag];
                    
                    *stop = YES;
                }
            }
        }];
    }
    
}



#pragma mark - 激活操作
/**
 激活路径
 */
- (void)activatePathWithTag:(NSString *)tag{
    RedDotPathInfo * pathInfo = [_pathStorage objectForKey:tag];
    if (pathInfo) { // 存有路径
        
        pathInfo.active = YES;
        [_pathStorage setObject:pathInfo forKey:tag];
        
    }
}

/**
 取消激活路径
 */
- (void)inactivatePathWithTag:(NSString *)tag{
    RedDotPathInfo * pathInfo = [_pathStorage objectForKey:tag];
    if (pathInfo) {
        pathInfo.active = NO;
        [_pathStorage setObject:pathInfo forKey:tag];
    }
}




@end
