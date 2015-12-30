//
//  AmusementViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "AmusementViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UniversalModel.h"
#import "UniversalTableViewCell.h"
#import "DetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JWCache.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSString+Common.h"
@interface AmusementViewController ()

@end

@implementation AmusementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, VIEW_HEIGHT-64) style:UITableViewStylePlain];
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

- (void)loadDataFromNet :(BOOL)isMore {
    
    
    NSInteger page = 1;
    if (isMore) {
        if (_dataArray.count%8 == 0) {
            page = _dataArray.count/8+1;
        } else {
            [_tableView.mj_footer endRefreshing];
            return;
        }
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setDictionary:PARAMETER];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    
    //请求数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_manager GET:AMUSEMENTURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UniversalModel *universalModel = [[UniversalModel alloc] initWithData:responseObject error:nil];
        if (!isMore) {
            [_dataArray removeAllObjects];
            [_tableView reloadData];
        }
        ResultModel *resultModel = universalModel.result;
        for (RstModel *model in resultModel.rst) {
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        //隐藏提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        //隐藏提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}



@end
