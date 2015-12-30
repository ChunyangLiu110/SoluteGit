//
//  HomePageTableViewCell.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HomePageTableViewCell {

    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_nameLabel;
    UILabel *_updateTimeLabel;
    UILabel *_commentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customViews];
    }
    return self;
}

- (void)customViews {
    
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_titleLabel];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_nameLabel];
    _updateTimeLabel = [[UILabel alloc] init];
    _updateTimeLabel.font = [UIFont systemFontOfSize:13];
    _updateTimeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_updateTimeLabel];
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.textColor = [UIColor lightGrayColor];
    _commentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_commentLabel];
    
}

- (void)setModel:(DataModel *)model {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.o_image] placeholderImage:[UIImage imageNamed:@"feed_cell_photo_default_big@2x"]];
    _titleLabel.text = model.title;
    if (model.author_list.count >= 1) {
        DataAuthor_list *listModel = model.author_list[0];
        _nameLabel.text = listModel.name;
    }
    
    NSString *time = [self transformTime:model.publishtime];
    _updateTimeLabel.text = time;
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",model.comment];
}

- (NSString *)transformTime: (NSString *)timeString {
    //时间戳转化为标准时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    if ([timeString integerValue] > 0) {
        NSDate *conFromTimeSp = [NSDate dateWithTimeIntervalSince1970:[timeString integerValue]];
        NSString *conFromTimeSpString = [formatter stringFromDate:conFromTimeSp];
        NSArray *array = [conFromTimeSpString componentsSeparatedByString:@" "];
        NSString *str = array[0];
        return str;
    }
    return nil;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat leftPadding = 12;
    CGFloat topPadding = 12;
    CGFloat padding = 8;
    CGSize size = self.contentView.frame.size;
    _imageView.frame = CGRectMake(leftPadding, topPadding, size.width-2*leftPadding,175);
    _imageView.layer.cornerRadius = 15;
    _imageView.clipsToBounds = YES;
    _titleLabel.frame = CGRectMake(leftPadding, CGRectGetMaxY(_imageView.frame)+padding/2, size.width-2*leftPadding, 43);
    _nameLabel.frame = CGRectMake(leftPadding, CGRectGetMaxY(_titleLabel.frame)+padding/2, 120, 9);
    _updateTimeLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMaxY(_titleLabel.frame)+padding/2, 120, 9);
    _commentLabel.frame = CGRectMake(size.width-leftPadding-50, CGRectGetMaxY(_titleLabel.frame)+padding/2, 50, 9);
}



- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
