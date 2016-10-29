//
//  ViewController.m
//  RedDotDemo
//
//  Created by 周潇 on 2016/10/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "ViewController.h"
#import "RedDotManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BarButton;
@property (weak, nonatomic) IBOutlet UIButton *navButton;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册UIView
    [[RedDotManager sharedManager] registerView:self.btn withPathTag:@"g" andDotPosition:RedDotPositionRight];
    [[RedDotManager sharedManager] registerView:self.lbl withPathTag:@"g" andDotWidth:40 andDotPosition:RedDotPositionBottom];
    // 取消注册UIView
//    [[RedDotManager sharedManager] quitRegisterView:self.lbl withPathTag:@"g"];
    
    // 注册tabBar
    [[RedDotManager sharedManager] registerTabBar:self.navigationController.tabBarController.tabBar atIndex:0 withPathTag:@"g" andDotWidth:30 andDotPosition:RedDotPositionCenter];
    // 取消注册tabBar
//    [[RedDotManager sharedManager] quitRegisterTabBar:self.navigationController.tabBarController.tabBar atIndex:0 withPathTag:@"g"];
    
    
    
    UIImageView * imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    UIBarButtonItem * leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:imgV];
    
    UIBarButtonItem * leftItem2 = [[UIBarButtonItem alloc] initWithTitle:@"hehe" style:UIBarButtonItemStylePlain target:self action:@selector(navClick)];
    
    
    self.navigationItem.rightBarButtonItems = @[leftItem1,leftItem2];
    [[RedDotManager sharedManager] registerView:imgV withPathTag:@"g"];
    // 注册navigationBar
    [[RedDotManager sharedManager] registerNavigationBar:self.navigationController.navigationBar atIndex:1 withPathTag:@"g" andDotPosition:RedDotPositionRight];
    // 取消注册navigationBar
    //    [[RedDotManager sharedManager] quitRegisterNavigationBar:self.navigationController.navigationBar atIndex:1 withPathTag:@"g"];
    
    UILabel * lbl = [[UILabel alloc] init];
    lbl.text = @"123";
    [lbl sizeToFit];
    self.navigationItem.titleView = lbl;
    [[RedDotManager sharedManager] registerView:self.navigationItem.titleView withPathTag:@"g"];
    [[RedDotManager sharedManager] registerView:self.navigationItem.titleView withPathTag:@"f"];
    
    
    
}

- (void)navClick{
    NSLog(@"clicked");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[RedDotManager sharedManager] activatePathWithTag:@"g"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
