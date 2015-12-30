//
//  HeadScrollView.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HeadScrollView.h"
#import "HomePageModel.h"
#import <UIImageView+WebCache.h>
@implementation HeadScrollView {

    CGFloat _singleWidth;
    CGRect _frame;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
   
    if (self = [super initWithFrame:frame]) {
        _frame = frame;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        
        
    }
    return self;
}
- (void)setScrollDataArray:(NSMutableArray *)scrollDataArray {
    
    _scrollDataArray = scrollDataArray;
//定制视图内容的时候需要在属性赋值后调用，与程序的执行顺序有关
    [self customViews];
}
- (void)customViews {
   

    _singleWidth = _frame.size.width;
    for (NSUInteger i = 0; i < _scrollDataArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i*_singleWidth, 0, _singleWidth, 180);
        CarouselModel *model = _scrollDataArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.o_image] placeholderImage:[UIImage imageNamed:@"feed_cell_photo_default_big@2x"]];
        CGFloat bottomPadding = 5;
        //类型label
        UILabel *typeLabel = [[UILabel alloc] init];
        if (!model.author_list) {
            typeLabel.frame = CGRectMake(10, imageView.frame.size.height-30-bottomPadding, 30, 20);
            typeLabel.backgroundColor = [UIColor redColor];
            typeLabel.textColor = [UIColor whiteColor];
            typeLabel.layer.cornerRadius = 5;
            typeLabel.clipsToBounds = YES;
            typeLabel.adjustsFontSizeToFitWidth = YES;
            typeLabel.text = model.type_name;
        }else {
            typeLabel.frame = CGRectMake(10, 0, 0, 0);
        }
        
        //标题label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(typeLabel.frame)+3, imageView.frame.size.height-40-bottomPadding, _singleWidth-30-10-3-10, 40);
        titleLabel.text = model.title;
        titleLabel.textColor = [UIColor whiteColor];
        //灰色背景条
        UIImageView *backgroundImageView = [[UIImageView alloc] init];
        backgroundImageView.frame = CGRectMake(0,imageView.frame.size.height-40-bottomPadding , _singleWidth, CGRectGetHeight(titleLabel.frame)+bottomPadding);
        backgroundImageView.backgroundColor = [UIColor blackColor];
        backgroundImageView.alpha = 0.7;
        //给每张imageView加上手势
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        imageView.tag = 10 + i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tgr];
        [imageView addSubview:backgroundImageView];
        [imageView addSubview:typeLabel];
        [imageView addSubview:titleLabel];
        [self addSubview:imageView];
        
    }
}




- (void)tapGestureAction:(UITapGestureRecognizer *)tapgesture {

    UIView *imageView = [tapgesture view];
    NSInteger index = imageView.tag - 10;
    CarouselModel *model = _scrollDataArray[index];
    if (_imageSeletedBlock) {
        _imageSeletedBlock(model);
    }
   
}




@end
