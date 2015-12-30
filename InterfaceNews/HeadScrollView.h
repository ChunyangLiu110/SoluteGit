//
//  HeadScrollView.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <UIKit/UIKit.h>



/*
@class HeadScrollView;
//代理协议
@protocol HeadScrollViewDelegate <NSObject>

- (void)headScrollViewDidSelected:(HeadScrollView *)headScrollView imageID:(NSString *)imageID;

@end
*/

@class CarouselModel;
typedef void(^imageSelectedBlock)(CarouselModel *model);

@interface HeadScrollView : UIScrollView

//用来接收滚动视图的数据源数组
@property (nonatomic, strong) NSMutableArray *scrollDataArray;
//用来传值的block(传model)
@property (nonatomic, copy) imageSelectedBlock imageSeletedBlock;

@property (nonatomic, weak) id <UIScrollViewDelegate> delegate;

@property (nonatomic, strong) UIPageControl *pageControl;

@end
