//
//  LeftViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "LeftViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "AppDelegate.h"
#import "AmusementViewController.h"
#import "HomePageViewController.h"
#import "SportsViewController.h"
#import "ITViewController.h"
#import "CarViewController.h"
#import "BuildingViewController.h"
#import "TechViewController.h"
#import "EstateViewController.h"
#import "InvestViewController.h"
#import "AfternoonViewController.h"
#import "HomePageViewController.h"
#import "WorldViewController.h"
#import "ChinaViewController.h"
#import "BusinessViewController.h"
@interface LeftViewController () <UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    NSArray *_dataArray;
}

@end

@implementation LeftViewController

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if (self.closeBlock) {
        self.closeBlock(YES);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (self.closeBlock) {
        self.closeBlock(NO);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    _dataArray = @[@"首页",@"天下",@"中国",@"商业",@"娱乐",@"体育",@"T界",@"瘾擎",@"歪楼",@"科技",@"房地产",@"投资",@"午间"];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftbackiamge"]];
    [self.view addSubview:background];
    self.view.userInteractionEnabled = YES;
    
    [self creatTbaleView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatTbaleView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 150, CGRectGetHeight(self.view.bounds)-150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.view addSubview:_tableView];
}

#pragma mark -- _tableView代理方法



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabBarController = appdelegate.tabBarController;
    
    NSArray *viewControllers = tabBarController.viewControllers;
    UINavigationController *nc = viewControllers[tabBarController.selectedIndex];
    NSLog(@"%ld",tabBarController.selectedIndex);
    switch (indexPath.row) {
            
        case 0:
        {
            HomePageViewController *homePageController = [[HomePageViewController alloc] init];
            homePageController.title = @"首页";
            homePageController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:homePageController animated:YES];
        }
            break;
            
        case 1:
        {
            WorldViewController *worldViewController = [[WorldViewController alloc] init];
            worldViewController.title = @"世界";
            worldViewController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:worldViewController animated:YES];
        }
            break;
            
        case 2:
        {
            ChinaViewController *chinaViewController = [[ChinaViewController alloc] init];
            chinaViewController.title = @"T界";
            chinaViewController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:chinaViewController animated:YES];
        }
            break;
        case 3:
        {
            BusinessViewController *businessViewController = [[BusinessViewController alloc] init];
            businessViewController.hidesBottomBarWhenPushed = YES;
            businessViewController.title = @"商业";
            [nc pushViewController:businessViewController animated:YES];
        }
            break;
        case 4:
        {
            BaseViewController *amuViewController = [[AmusementViewController alloc] init];
            amuViewController.title = @"娱乐";
            amuViewController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:amuViewController animated:YES];
        }
            break;
            
        case 5:
        {
            SportsViewController *sportViewController = [[SportsViewController alloc] init];
            sportViewController.title = @"体育";
            sportViewController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:sportViewController animated:YES];
        }
            break;
            
        case 6:
        {
            ITViewController *itViewController = [[ITViewController alloc] init];
            itViewController.title = @"T界";
            itViewController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:itViewController animated:YES];
        }
            break;
        case 7:
        {
            CarViewController *carViewController = [[CarViewController alloc] init];
            carViewController.hidesBottomBarWhenPushed = YES;
            carViewController.title = @"瘾擎";
            
            [nc pushViewController:carViewController animated:YES];
        }
            break;
        case 8:
        {
            BuildingViewController *buildingController = [BuildingViewController new];
            buildingController.title = @"歪楼";
            buildingController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:buildingController animated:YES];
        }
            break;
        case 9:
        {
            TechViewController *techController = [TechViewController new];
            techController.title = @"科技";
            techController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:techController animated:YES];
        }
            break;
        case 10:
        {
            EstateViewController *estateController = [EstateViewController new];
            estateController.title = @"房地产";
            estateController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:estateController animated:YES];
        }
            break;
        case 11:
        {
            InvestViewController *investController = [InvestViewController new];
            investController.title = @"投资";
            investController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:investController animated:YES];
        }
            break;
        case 12:
        {
            AfternoonViewController *afternoonController = [AfternoonViewController new];
            afternoonController.title = @"午间";
            afternoonController.hidesBottomBarWhenPushed = YES;
            [nc pushViewController:afternoonController animated:YES];
        }
            break;
        default:
            break;
    }
}
























@end
