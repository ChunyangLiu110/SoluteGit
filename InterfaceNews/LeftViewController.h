//
//  LeftViewController.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBlock) (BOOL isOpen);
@interface LeftViewController : UIViewController

@property (nonatomic, copy) CloseBlock closeBlock;

@end
