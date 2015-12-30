//
//  AppDelegate.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "TabBarController.h"
@class LeftViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MMDrawerController *mmDrawerController;

@property (nonatomic, strong) TabBarController *tabBarController;

@property (nonatomic, strong) LeftViewController *leftViewController;

@end

