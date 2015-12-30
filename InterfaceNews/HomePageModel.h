//
//  HomePageModel.h
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DataAuthor_list : JSONModel
@property (nonatomic, copy) NSString <Optional>*uid;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*head_img;
@property (nonatomic, copy) NSString <Optional>*url;
@property (nonatomic, copy) NSString <Optional>*is_v;
@property (nonatomic, copy) NSString <Optional>*is_show_v;
@property (nonatomic, copy) NSString <Optional>*remark;
@property (nonatomic, copy) NSString <Optional>*user_other;
@property (nonatomic, copy) NSString <Optional>*weixin;
@end

@protocol DataAuthor_list
@end


@interface DataModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*id;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*tags;
@property (nonatomic, copy) NSString <Optional>*image_path;
@property (nonatomic, copy) NSString <Optional>*z_image;
@property (nonatomic, copy) NSString <Optional>*s_image;
@property (nonatomic, copy) NSString <Optional>*m_image;
@property (nonatomic, copy) NSString <Optional>*o_image;
@property (nonatomic, copy) NSString <Optional>*c_image;
@property (nonatomic, copy) NSString <Optional>*cl_image;
@property (nonatomic, copy) NSString <Optional>*from;
@property (nonatomic, copy) NSString <Optional>*summary;
@property (nonatomic, copy) NSString <Optional>*published;
@property (nonatomic, copy) NSString <Optional>*publishtime;
@property (nonatomic, copy) NSString <Optional>*headline;
@property (nonatomic, copy) NSString <Optional>*hit;
@property (nonatomic, copy) NSString <Optional>*status;
@property (nonatomic, copy) NSString <Optional>*i_show_tpl;
@property (nonatomic, copy) NSString <Optional>*img;
@property (nonatomic, copy) NSString <Optional>*comment;
@property (nonatomic, strong) NSMutableArray <DataAuthor_list,Optional>*author_list;
@end

@protocol DataModel
@end

@interface  HomeRstModel: JSONModel
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, strong) NSMutableArray <DataModel,Optional>*data;
@end


@interface  HomeAuthor_listModel: JSONModel
@property (nonatomic, copy) NSString <Optional>*uid;
@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*head_img;
@property (nonatomic, copy) NSString <Optional>*url;
@property (nonatomic, copy) NSString <Optional>*is_v;
@property (nonatomic, copy) NSString <Optional>*is_show_v;
@property (nonatomic, copy) NSString <Optional>*remark;
@property (nonatomic, copy) NSString <Optional>*user_other;
@property (nonatomic, copy) NSString <Optional>*weixin;
@end

@protocol HomeAuthor_listModel
@end

@interface CarouselModel : JSONModel
@property (nonatomic,copy) NSString <Optional>*id;
@property (nonatomic,copy) NSString <Optional>*title;
@property (nonatomic,copy) NSString <Optional>*tags;
@property (nonatomic,copy) NSString <Optional>*image_path;
@property (nonatomic,copy) NSString <Optional>*z_image;
@property (nonatomic,copy) NSString <Optional>*s_image;
@property (nonatomic,copy) NSString <Optional>*o_image;
@property (nonatomic,copy) NSString <Optional>*c_image;
@property (nonatomic,copy) NSString <Optional>*cl_image;
@property (nonatomic,copy) NSString <Optional>*summary;
@property (nonatomic,copy) NSString <Optional>*published;
@property (nonatomic,copy) NSString <Optional>*publishtime;
@property (nonatomic,copy) NSString <Optional>*headline;
@property (nonatomic,copy) NSString <Optional>*comment;
@property (nonatomic,copy) NSString <Optional>*hit;
@property (nonatomic,copy) NSString <Optional>*status;
@property (nonatomic,copy) NSString <Optional>*i_show_tpl;
@property (nonatomic,copy) NSString <Optional>*img;
@property (nonatomic,copy) NSString <Optional>*type_name;
@property (nonatomic,strong) NSMutableArray <HomeAuthor_listModel,Optional> *author_list;
@end

@protocol CarouselModel
@end

@protocol HomeRstModel
@end

@interface HomeResultModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*count;
@property (nonatomic, copy) NSString <Optional>*pageCount;
@property (nonatomic, copy) NSString <Optional>*page;
@property (nonatomic, copy) NSMutableArray <CarouselModel,Optional>*carousel;
@property (nonatomic, strong) NSMutableArray <HomeRstModel,Optional> *rst;
@end

@interface HomePageModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*code;
@property (nonatomic, copy) NSString <Optional>*message;
@property (nonatomic, strong) HomeResultModel *result;

@end
