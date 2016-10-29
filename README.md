# RedDotManager

**一个小红点提示的管理方案.**

当界面需要用小红点引导用户点击时，事先向RedDotManager注册一个路径名；当需要激活路径的时候，在任何时候任何地方，都可以通过RedDotManager激活，就可以看到鲜活的小红点提示出现。
<img src="images/小红点.gif" height="500"/>

# 安装

**手动安装**

将RedDot文件夹拖入工程即可

# 使用方法

**注册**

```
// 注册UIView视图控件
[[RedDotManager sharedManager] registerView:self.btn withPathTag:@"tagName"];

// 注册tabBar中的item
[[RedDotManager sharedManager] registerTabBar:self.navigationController.tabBarController.tabBar atIndex:0 withPathTag:@"tagName" andDotWidth:30 andDotPosition:RedDotPositionCenter];

// 注册自定义view的navItem
UIImageView * imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
UIBarButtonItem * leftItem1 = [[UIBarButtonItem alloc] initWithCustomView:imgV];
[[RedDotManager sharedManager] registerView:imgV withPathTag:@"tagName"];

// 注册没有自定义view的navItem
UIBarButtonItem * leftItem2 = [[UIBarButtonItem alloc] initWithTitle:@"nav" style:UIBarButtonItemStylePlain target:self action:@selector(navClick)];

self.navigationItem.rightBarButtonItems = @[leftItem1,leftItem2];
    
// 注册navigationBar
[[RedDotManager sharedManager] registerNavigationBar:self.navigationController.navigationBar atIndex:1 withPathTag:@"tagName" andDotPosition:RedDotPositionRight];

// 注册navBar的title
UILabel * lbl = [[UILabel alloc] init];
lbl.text = @"title";
[lbl sizeToFit];
self.navigationItem.titleView = lbl;
[[RedDotManager sharedManager] registerView:self.navigationItem.titleView withPathTag:@"tagName"];
    
```

**取消注册**

```

 // 取消注册UIView
[[RedDotManager sharedManager] quitRegisterView:self.btn withPathTag:@"tagName"];


// 取消注册tabBar
[[RedDotManager sharedManager] quitRegisterTabBar:self.navigationController.tabBarController.tabBar atIndex:0 withPathTag:@"tagName"];


// 取消注册navigationBar
[[RedDotManager sharedManager] quitRegisterNavigationBar:self.navigationController.navigationBar atIndex:1 withPathTag:@"tagName"];
    
```

**激活**

```
[[RedDotManager sharedManager] activatePathWithTag:@"tagName"];
```

**取消激活**

```
[[RedDotManager sharedManager] inactivatePathWithTag:@"tagName"];
```




