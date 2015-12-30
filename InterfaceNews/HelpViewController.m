//
//  HelpViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HelpViewController.h"
#import "SoftwareViewController.h"
#import "SuggestViewController.h"
#import "JWCache.h"
@interface HelpViewController ()<UIAlertViewDelegate>

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    [self creatViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatViews {

    UIImage *backgroundImage = [UIImage imageNamed:@"login_bg"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    backgroundImageView.userInteractionEnabled = YES;
//四个button
    UIImage *image = [UIImage imageNamed:@"login_entry_email"];
    NSArray *titles = @[@"关于软件",@"缓存清理",@"反馈与建议",@"退出"];
    CGFloat gap = 15;
    for (NSUInteger i = 0; i < titles.count; i++) {
        NSString *buttontitle = titles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        CGSize size = image.size;
        button.frame = CGRectMake((VIEW_WIDTH - size.width)/2, VIEW_HEIGHT/5+(size.height+gap)*i, size.width, size.height);
        [button setTitle:buttontitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        [button.titleLabel sizeToFit];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImageView addSubview:button];
    }
    [self.view addSubview:backgroundImageView];
    
}

- (void)buttonAction:(UIButton *)button {

    NSUInteger tag = button.tag;
    switch (tag) {
        case 1000:
        {
            SoftwareViewController *softController = [[SoftwareViewController alloc] init];
            [self.navigationController pushViewController:softController animated:YES];
        }
            break;
        case 1001:
        {
            [self createAlertView];
        }
            break;
        case 1002:
        {
            SuggestViewController *softController = [[SuggestViewController alloc] init];
            [self.navigationController pushViewController:softController animated:YES];
        }
            break;
        case 1003:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)createAlertView {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"⚠️" message:@"您确定清理缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex != alertView.cancelButtonIndex) {
        if (alertView.tag == 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清理完成！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [JWCache resetCache];
            [alert show];

        }
    }
}

@end
