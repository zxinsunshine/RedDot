//
//  RedDotProtocol.h
//

#import <UIKit/UIKit.h>
#import "RedDotConstants.h"


@protocol RedDotProtocol <NSObject>



/**
 小红点管理者单例
 */
+ (instancetype)sharedManager;

#pragma mark - 注册视图UIView
/**
 注册视图，指定路径名
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag;

/**
 注册视图，指定路径名和红点大小
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth;


/**
 注册视图，指定路径名、当前视图的红点位置
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition;
 
 /**
 - 注册视图，指定路径名、当前视图的红点大小、红点位置、是否为终点
 - （最终的设定方法）
 */
- (void)registerView:(UIView *)view withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition;

/**
 取消注册视图
 */
- (void)quitRegisterView:(UIView *)view withPathTag:(NSString *)tag;



#pragma mark - 注册TabBar
/**
 注册TabBar的第i个图标（0~N-1），指定路径名
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag;

/**
 注册TabBar的第i个图标（0~N-1），指定路径名和红点大小
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag  andDotWidth:(CGFloat)dotWidth;


/**
 注册TabBar的第i个图标（0~N-1），指定路径名、当前视图的红点位置
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition;

/**
 注册TabBar的第i个图标（0~N-1），指定路径名、当前视图的红点大小、红点位置、是否为终点
 - （最终的设定方法）
 */
- (void)registerTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition;

/**
 取消注册TabBar的第i个图标（0~N-1）
 */
- (void)quitRegisterTabBar:(UITabBar *)tabBar atIndex:(NSInteger)tabIdx withPathTag:(NSString *)tag;


#pragma mark - 注册NavigationBar
/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag;

/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名和红点大小；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag  andDotWidth:(CGFloat)dotWidth;


/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名、当前视图的红点位置；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag andDotPosition:(RedDotPosition)dotPosition;

/**
 注册NavigationBar的第i个图标（从左往右数），指定路径名、当前视图的红点大小、红点位置、是否为终点；
 注意：左边边从左往右数，右边从右往左数
 - （最终的设定方法）
 */
- (void)registerNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag andDotWidth:(CGFloat)dotWidth andDotPosition:(RedDotPosition)dotPosition;

/**
 注册NavigationBar的第i个图标（从左往右数；
 注意：左边边从左往右数，右边从右往左数
 */
- (void)quitRegisterNavigationBar:(UINavigationBar *)navigationBar atIndex:(NSInteger)naviBarIdx withPathTag:(NSString *)tag;




#pragma mark - 激活操作
/**
 激活路径
 */
- (void)activatePathWithTag:(NSString *)tag;


/**
 取消激活路径
 */
- (void)inactivatePathWithTag:(NSString *)tag;



@end
