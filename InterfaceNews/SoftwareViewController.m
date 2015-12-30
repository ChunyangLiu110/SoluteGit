//
//  SoftwareViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "SoftwareViewController.h"

@interface SoftwareViewController ()

@end

@implementation SoftwareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"关于软件";
    
    [self creatViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatViews {

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"start_guide_3@2x.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *authorLabel = [[UILabel alloc] init];
    authorLabel.text = @"Jackson Liu";
    authorLabel.font = [UIFont systemFontOfSize:20];
    authorLabel.frame = CGRectMake(220, 540, 200, 30);
    authorLabel.textColor = [UIColor whiteColor];
    [self .view addSubview:authorLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"只服务与勤于思考的人";
    contentLabel.frame = CGRectMake(165, 580, 200, 30);
    contentLabel.font = [UIFont systemFontOfSize:20];
    contentLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:contentLabel];
   
}

@end
