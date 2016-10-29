//
//  RedDotPathInfo.h


#import <Foundation/Foundation.h>

@interface RedDotPathInfo : NSObject

/**
 路径名
 */
@property(nonatomic,copy)NSString * pathName;

/**
 路径节点数
 */
@property(nonatomic,assign)NSInteger pointNumber;


/**
 是否激活
 */
@property(nonatomic,assign,getter=isActive)BOOL active;

/**
 初始化方法
 */
- (instancetype)initWithName:(NSString *)pathName andPointNumber:(NSInteger)pointNumber;


@end
