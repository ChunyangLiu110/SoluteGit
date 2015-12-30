//
//  WorldViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "WorldViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UniversalModel.h"
#import "UniversalTableViewCell.h"
#import "DetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "JWCache.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "NSString+Common.h"
@interface WorldViewController ()

@end

@implementation WorldViewController {

    NSMutableString *_keyString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [JWCache resetCache];
    _keyString = [[NSMutableString alloc] init];
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
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setDictionary:PARAMETER];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    
    //请求数据
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     _keyString = [NSMutableString stringWithFormat:@"%@%ld",WORLDURL,page];
    NSData *cacheData = [JWCache objectForKey:MD5Hash(_keyString)];

    if (cacheData) {
        
        UniversalModel *universalModel = [[UniversalModel alloc] initWithData:cacheData error:nil];
        if (isMore) {
            ResultModel *resultModel = universalModel.result;
            for (RstModel *model in resultModel.rst) {
                [_dataArray addObject:model];
                [_tableView reloadData];
            }
        } else {
            [_dataArray removeAllObjects];
            ResultModel *resultModel = universalModel.result;
            for (RstModel *model in resultModel.rst) {
                [_dataArray addObject:model];
                [_tableView reloadData];
            }
        }
        
            [_tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        return;
    }
    [_manager GET:WORLDURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
//把数据进行缓存
       
        [JWCache setObject:responseObject forKey:MD5Hash(_keyString)];
        NSLog(@"222222%@",_keyString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
//隐藏提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}








@end
