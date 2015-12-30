//
//  BaseViewController.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>



@interface BaseViewController : UIViewController {
//公开父类的属性
    AFHTTPRequestOperationManager *_manager;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}
//用来区分每个子类的类型
@property (nonatomic, copy) NSString *categotyType;
//每个子类对应的url
@property (nonatomic, copy) NSString *requestURL;

@property (nonatomic, assign) BOOL isOpen;
@end
