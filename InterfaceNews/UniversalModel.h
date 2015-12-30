//
//  UniversalModel.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Author_listModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*uid;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*url;
@end

@protocol  Author_listModel
@end

@interface RstModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*id;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*tags;
@property (nonatomic, copy) NSString <Optional>*image_path;
@property (nonatomic, copy) NSString <Optional>*z_image;
@property (nonatomic, copy) NSString <Optional>*s_image;
@property (nonatomic, copy) NSString <Optional>*m_image;
@property (nonatomic, copy) NSString <Optional>*o_image;
@property (nonatomic, copy) NSString <Optional>*l_image;
@property (nonatomic, copy) NSString <Optional>*cl_image;
@property (nonatomic, copy) NSString <Optional>*from;
@property (nonatomic, copy) NSString <Optional>*summary;
@property (nonatomic, copy) NSString <Optional>*published;
@property (nonatomic, copy) NSString <Optional>*publishtime;
@property (nonatomic, copy) NSString <Optional>*update_time;
@property (nonatomic, copy) NSString <Optional>*keywords;
@property (nonatomic, copy) NSString <Optional>*description;
@property (nonatomic, copy) NSString <Optional>*headline;
@property (nonatomic, copy) NSString <Optional>*quotation;
@property (nonatomic, copy) NSString <Optional>*t_recommend;
@property (nonatomic, copy) NSString <Optional>*comment;
@property (nonatomic, copy) NSString <Optional>*collect;
@property (nonatomic, copy) NSString <Optional>*share;
@property (nonatomic, copy) NSString <Optional>*recommend;
@property (nonatomic, copy) NSString <Optional>*audit;
@property (nonatomic, copy) NSString <Optional>*ding;
@property (nonatomic, copy) NSString <Optional>*hit;
@property (nonatomic, copy) NSString <Optional>*day_hit;
@property (nonatomic, copy) NSString <Optional>*week_hit;
@property (nonatomic, copy) NSString <Optional>*month_hit;
@property (nonatomic, copy) NSString <Optional>*sign;
@property (nonatomic, copy) NSString <Optional>*status;
@property (nonatomic, copy) NSString <Optional>*survey_id;
@property (nonatomic, copy) NSString <Optional>*img;
@property (nonatomic, copy) NSString <Optional>*smalltitle;
@property (nonatomic, strong) NSMutableArray <Optional,Author_listModel>*author_list;
@property (nonatomic, copy) NSString <Optional>*i_show_tpl;
@end

@protocol RstModel
@end

@interface ResultModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*count;
@property (nonatomic, copy) NSString <Optional>*pageCount;
@property (nonatomic, copy) NSString <Optional>*page;

@property (nonatomic, strong) NSMutableArray <RstModel,Optional>*rst;
@end

@interface UniversalModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*code;
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, strong) ResultModel *result;
@end
