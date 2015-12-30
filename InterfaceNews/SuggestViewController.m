//
//  SuggestViewController.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "SuggestViewController.h"

@interface SuggestViewController  ()<UITextViewDelegate>

@end

@implementation SuggestViewController {

    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"反馈与建议";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTextFieldAndButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatTextFieldAndButton {

    UITextView *textField = [[UITextView alloc] init];
    textField.frame = CGRectMake(50, 100, VIEW_WIDTH-100,150);
    textField.font = [UIFont systemFontOfSize:15];
    textField.layer.borderColor = [[UIColor grayColor] CGColor];
    textField.layer.borderWidth = 1.0;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    _label = [[UILabel alloc] init];
    _label.text = @"请提出您的宝贵意见......";
    _label.textColor = [UIColor grayColor];
    _label.font = [UIFont systemFontOfSize:15];
    _label.frame = CGRectMake(CGRectGetMinX(textField.frame)+5, CGRectGetMinY(textField.frame)+10, CGRectGetWidth(textField.frame), 20);
    [self.view addSubview:_label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(CGRectGetMaxX(textField.frame)-50, CGRectGetMaxY(textField.frame)+10, 50, 30);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
#pragma mark -- UITextView代理方法

- (void)buttonAction:(UIButton *)button {

    [self createAlertView];
}

- (void)createAlertView {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"⚠️" message:@"您确定提交吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        if (alertView.tag == 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提交成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {

    [_label removeFromSuperview];
}


@end
