//
//  RedDotPathInfo.m


#import "RedDotPathInfo.h"
#import "RedDotConstants.h"

@implementation RedDotPathInfo


/**
 初始化方法
 */
- (instancetype)initWithName:(NSString *)pathName andPointNumber:(NSInteger)pointNumber{
    
    self = [super init];
    if (self) {
        self.pathName = pathName;
        self.pointNumber = pointNumber;

    }
    return self;
}

/**
 激活路径
 */
- (void)setActive:(BOOL)active{
    
    _active = active;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"%@%@",RedDotNotifationPrefix,_pathName] object:@(active)];
    
    
    
}

@end
