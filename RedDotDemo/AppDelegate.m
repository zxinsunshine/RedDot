//
//  AppDelegate.m
//  RedDotDemo
//
//  Created by 周潇 on 2016/10/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "AppDelegate.h"
#import "UIView+AutoLayout.h"
#import "UIView+RedDot.h"
#import "ViewController.h"

#import "RedDotManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    
    UITabBarController * tab = [[UITabBarController alloc] init];
    
    for (int i = 0; i < 4; ++i) {
        
        UINavigationController * nav = nil;
        UIViewController * vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        if (i==0) {
            
            UIStoryboard * s = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            nav = [s instantiateInitialViewController];
            nav.title = [NSString stringWithFormat:@"xxxx%d",i];
            nav.tabBarItem.image = [UIImage imageNamed:@"search"];
            
            
        }
        else{
            vc.title = [NSString stringWithFormat:@"控制器,%d",i];
            nav = [[UINavigationController alloc] initWithRootViewController:vc];
            nav.tabBarItem.image = [UIImage imageNamed:@"search"];
        }
        
    
        
        
        [tab addChildViewController:nav];
    }
    
    
    
    self.window.rootViewController = tab;
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
