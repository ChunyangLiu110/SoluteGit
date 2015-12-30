//
//  HomePageViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageModel.h"
#import "HomePageTableViewCell.h"
#import "DetailViewController.h"
#import <UIImageView+WebCache.h>
#import "HeadScrollView.h"
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "JWCache.h"
#import "NSString+Common.h"
#import "HeadDetailViewController.h"
//创建抽屉
#import <MMDrawerController/MMDrawerController.h>
#import "LeftViewController.h"
#import "AppDelegate.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    
    NSMutableArray *_cellDataArray;
    NSMutableArray *_scrollDataArray;
    UIView *_fatherView;
    HeadScrollView *_headScrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    NSInteger _i;
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellDataArray = [[NSMutableArray alloc] init];
    _scrollDataArray = [[NSMutableArray alloc] init];
    
//    [self creatTimer];
    //数据请求成功加入数组以后创建滚动视图（封装）
    _fatherView = [[UIView alloc] init];
    _fatherView.frame = CGRectMake(0, 0, VIEW_WIDTH, 210);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatTimer {

    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoMoveScrollView:) userInfo:nil repeats:YES];
}

- (void)autoMoveScrollView:(NSTimer *)timer {
    
    if (_i == _scrollDataArray.count) {
        _i = 0;
    }
    _headScrollView.contentOffset = CGPointMake(_i++*VIEW_WIDTH, 0);
    
}


- (void)creatTableView {
    //取消导航对滚动视图的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT-64) style:UITableViewStylePlain];
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"上拉刷新");
        [self loadDataFromNet:NO];
    }];
    _tableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"加载更多");
        [self loadDataFromNet:YES];
    }];
    _tableView.mj_footer = footer;
    [_tableView.mj_header beginRefreshing];
    
}


- (void)loadDataFromNet:(BOOL)isMore {
    
    
    NSInteger page = 1;
    if (isMore) {
        if (_cellDataArray.count%33 == 0) {
            page = _cellDataArray.count/33;
        } else {
            [_tableView.mj_footer endRefreshing];
            return;
        }
        
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setDictionary:PARAMETER];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    //请求数据
    [_manager GET:HOMEPAGEURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HomePageModel *homePageModel = [[HomePageModel alloc] initWithData:responseObject error:nil];
        
        //滚动视图所需要的model (判断避免重复加入数据)
        if (_scrollDataArray.count <= 0) {
            for (CarouselModel *carouselModel in homePageModel.result.carousel) {
                [_scrollDataArray addObject:carouselModel];
            }
        }
        if (homePageModel.result.carousel.count > 0) {
            _headScrollView = [[HeadScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 210)];
            _headScrollView.scrollDataArray = _scrollDataArray;
            _headScrollView.delegate = self;
            __weak typeof(self) weakSelf = self;
            _headScrollView.imageSeletedBlock = ^(CarouselModel *model){
                HeadDetailViewController *hvc = [[HeadDetailViewController alloc] init];
                hvc.model = model;
                hvc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:hvc animated:YES];
            };

            [_fatherView addSubview:_headScrollView];
//            创建pageControl
            [self creatPageControl];
            [_fatherView addSubview:_pageControl];
            _headScrollView.contentSize =CGSizeMake(homePageModel.result.carousel.count*VIEW_WIDTH, 210);
            _tableView.tableHeaderView = _fatherView;
            
        }
        //cell所需要的数据模型
        if (!isMore) {
            [_cellDataArray removeAllObjects];
            [_tableView reloadData];
        }
        for (HomeRstModel *homeRstModel in homePageModel.result.rst) {
            for (DataModel *dataModel in homeRstModel.data) {
                [_cellDataArray addObject:dataModel];
            }
        }
        [_tableView reloadData];
        //        NSLog(@"----%ld",_cellDataArray.count);
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}

- (void)creatPageControl {
    
    //创建pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(VIEW_WIDTH/4, CGRectGetMaxY(_headScrollView.frame)-40, VIEW_WIDTH, 0);
    _pageControl.numberOfPages = _scrollDataArray.count;
    _pageControl.userInteractionEnabled = NO;
    
}

//数据源发生了改变，重写数据源代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellID";
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _cellDataArray[indexPath.row];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feed_cell_photo_default_big@2x"]];
    cell.backgroundView = backgroundView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.model = _cellDataArray[indexPath.row];
    
    dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dvc animated:YES];
}


#pragma mark -- UIScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //减速结束时根据滚动视图偏移量更新当前页码
    
    _pageControl.currentPage = _headScrollView.contentOffset.x/_headScrollView.frame.size.width;
    
}



@end
