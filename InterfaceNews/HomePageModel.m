//
//  HomePageModel.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "HomePageModel.h"

@implementation DataAuthor_list

@end

@implementation DataModel
+ (JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Dataid"}];
}
@end

@implementation HomeRstModel

@end

@implementation HomeAuthor_listModel

@end

@implementation CarouselModel

+(JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Carouseid"}];
}
@end

@implementation HomeResultModel

@end

@implementation HomePageModel

@end
