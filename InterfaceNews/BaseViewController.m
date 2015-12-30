//
//  BaseViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "BaseViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UniversalModel.h"
#import "UniversalTableViewCell.h"
#import "DetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JWCache.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import "LeftViewController.h"
#import "HelpViewController.h"
@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [self customNavigationBar];
    
    [self initRequestManager];
    
    [self creatTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)customNavigationBar {
    
    //title
    UIImage *image = [UIImage imageNamed:@"channel_jm"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 40, 35);
    self.navigationItem.titleView = imageView;
    
    //rightButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    UIImage *normalImage = [[UIImage imageNamed:@"icon_subcribe"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    UIImage *selectedImage = [[UIImage imageNamed:@"icon_subcribe_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setBackgroundImage:selectedImage  forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    //leftButton(此处的barButton必须使用系统的，否则无法滑开左侧抽屉)
    UIBarButtonItem *leftbarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(openLeftSide:)];
    [leftbarButtonItem setImage:[UIImage imageNamed:@"menu"]];
    self.navigationItem.leftBarButtonItem = leftbarButtonItem;
    
    
}

- (void)openLeftSide:(UIButton *)leftButton {

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LeftViewController *lefv = delegate.leftViewController;
    lefv.closeBlock = ^(BOOL isOpen) {
        _isOpen = isOpen;
    };
    if (_isOpen) {
        [delegate.mmDrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        }];
    } else {
        [delegate.mmDrawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            
        }];
    }
}

- (void)rightButtonClick:(UIButton *)rightButton {
    
    HelpViewController *helpViewController = [[HelpViewController alloc] init];
    helpViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:helpViewController animated:YES];
}

- (void)creatTableView {

    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"上拉刷新");
        [self loadDataFromNetWithURL:NO];
    }];
    _tableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self loadDataFromNetWithURL:YES];
    }];
    _tableView.mj_footer = footer;
    [_tableView.mj_header beginRefreshing];
    
}

- (void)initRequestManager {
    
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}

- (void)loadDataFromNetWithURL :(BOOL)isMore {

    NSInteger page = 1;
    NSString *urlString = nil;
    if (isMore) {
        if (_dataArray.count%10 == 0) {
            page = _dataArray.count/10;
        }
        return;
    }
    //请求数据
    [_manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UniversalModel *universalModel = [[UniversalModel alloc] initWithData:responseObject error:nil];
        ResultModel *resultModel = universalModel.result;
        for (RstModel *model in resultModel.rst) {
            [_dataArray addObject:model];
            [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
}

#pragma mark -- 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellID";
    UniversalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UniversalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _dataArray[indexPath.row];
      UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feed_cell_photo_default_big@2x"]];
    cell.backgroundView = backgroundView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

//选中cell时执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.model = _dataArray[indexPath.row];
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate.mmDrawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    self.isOpen = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate.mmDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}



@end
