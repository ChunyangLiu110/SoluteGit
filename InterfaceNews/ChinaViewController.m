//
//  ChinaViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "ChinaViewController.h"

@interface ChinaViewController ()<UITableViewDataSource,UITableViewDelegate> {

}

@end

@implementation ChinaViewController

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
        if (_dataArray.count%10 == 0) {
            page = _dataArray.count/10+1;
        } else {
            [_tableView.mj_footer endRefreshing];
            return;
        }
        
    }
    NSLog(@"%ld",page);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setDictionary:PARAMETER];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    //请求数据
    [_manager GET:CHINAURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}

@end
