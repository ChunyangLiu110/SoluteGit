//
//  HeadDetailViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HeadDetailViewController.h"
#import <WebKit/WebKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
@interface HeadDetailViewController () <UIWebViewDelegate> {


    UIWebView *_webView;
    NSString *_requestUrl;
}

@end

@implementation HeadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)createWebView {

    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *str = [NSString stringWithFormat:DETAILURL,_model.id];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *str = [htmlString stringByReplacingOccurrencesOfString:@"src"withString:@""];
        NSString *str1 = [str stringByReplacingOccurrencesOfString:@"App下载" withString:@""];
        NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"关注界面" withString:@""];
        NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"var domainIMG" withString:@""];
        NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"logo" withString:@""];
        NSString *str5 = [str4 stringByReplacingOccurrencesOfString:@"location.href" withString:@""];
        NSString *str6 = [str5 stringByReplacingOccurrencesOfString:@"article-content" withString:@""];
        NSString *str7 = [str6 stringByReplacingOccurrencesOfString:@"article-ad" withString:@""];
        NSString *str8 = [str7 stringByReplacingOccurrencesOfString:@"content-news-user-view" withString:@""];
        NSString *str9 = [str8 stringByReplacingOccurrencesOfString:@"news-share" withString:@""];
        NSString *str10 = [str9 stringByReplacingOccurrencesOfString:@"share-box-layout" withString:@""];
        NSString *str11 = [str10 stringByReplacingOccurrencesOfString:@"top-five" withString:@""];
        NSString *str12 = [str11 stringByReplacingOccurrencesOfString:@"click" withString:@""];
        [_webView loadHTMLString:str12 baseURL:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    _webView.delegate = self;
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark -- 视图控制器生命周期方法

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.mmDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.mmDrawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

#pragma mark -- 去广告代理方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest *request = navigationAction.request;
    NSString *url = [[request URL]absoluteString];
    if ([url isEqualToString:_requestUrl]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}


@end
