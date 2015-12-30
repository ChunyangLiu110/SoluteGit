//
//  UniversalModel.m
//  InterfaceNews
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//

#import "UniversalModel.h"

@implementation Author_listModel

@end

//RstModel中的关键字映射
@implementation RstModel

+ (JSONKeyMapper *)keyMapper {

    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"rid",@"description":@"desc"}];
}
@end

@implementation ResultModel

@end

@implementation UniversalModel

@end
