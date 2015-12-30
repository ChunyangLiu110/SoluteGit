//
//  NSString+Common.h
//  IFree
//
//  Created by qianfeng on 15/12/10.
//  Copyright © 2015年 Jackson Liu. All rights reserved.
//


//URL编码转换

#import <Foundation/Foundation.h>

@interface NSString (Common)

NSString * URLEncodedString(NSString *str);

NSString * MD5Hash(NSString *aString);

@end
