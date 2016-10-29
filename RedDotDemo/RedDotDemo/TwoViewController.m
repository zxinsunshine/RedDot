//
//  TwoViewController.m
//  RedDotDemo
//
//  Created by 周潇 on 2016/10/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "TwoViewController.h"
#import "RedDotManager.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation TwoViewController
- (IBAction)click:(id)sender {
    
    [[RedDotManager sharedManager] activatePathWithTag:@"g"];
    [[RedDotManager sharedManager] activatePathWithTag:@"f"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册
    [[RedDotManager sharedManager] registerView:self.lbl withPathTag:@"g" andDotPosition:RedDotPositionLeftTop];
    [[RedDotManager sharedManager] registerView:self.lbl2 withPathTag:@"g" andDotPosition:RedDotPositionBottom];
    [[RedDotManager sharedManager] registerView:self.btn withPathTag:@"g"];
    [[RedDotManager sharedManager] registerView:self.btn withPathTag:@"f"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[RedDotManager sharedManager] inactivatePathWithTag:@"g"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
