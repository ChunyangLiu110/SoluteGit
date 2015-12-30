//
//  TabBarController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "TabBarController.h"
#import "BaseViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "LeftViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
//    [self creatSplashView];
    [self creatViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatSplashView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,VIEW_WIDTH , VIEW_HEIGHT)];
    NSString *splashPath = [[NSBundle mainBundle] pathForResource:@"LaunchImage-568h@2x" ofType:@"png"];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:splashPath];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:2 animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


- (void)creatViewControllers {
    //TabBarController所管理的视图控制器
    NSMutableArray *allControllers = [[NSMutableArray alloc] init];
    //tabBarController的item属性
    NSArray *titles = @[@[@"首页",@"HomePage",@"icon_home"],
                        @[@"天下",@"World",@"icon_msg"],
                        @[@"中国",@"China",@"icon_search"],
                        @[@"商业",@"Business",@"icon_setting"]];
    for (NSUInteger i = 0; i < titles.count; i++) {
        //拼接视图控制器类名
        Class cls = NSClassFromString([NSString stringWithFormat:@"%@ViewController",titles[i][1]]);
        BaseViewController *bvc = [[cls alloc] init];
        bvc.title = titles[i][0];
        NSString *normalImageName = [NSString stringWithFormat:@"%@",titles[i][2]];
        UIImage *normalImage = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *selectedImageName = [normalImageName stringByAppendingString:@"_s"];
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i][0] image:normalImage selectedImage:selectedImage];
        bvc.tabBarItem = item;
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:bvc];
        [allControllers addObject:nc];
    }
    self.viewControllers = allControllers;

}





@end
