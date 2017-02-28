//
//  JsonUtil.h
//  zhefengle
//
//  Created by dasheng on 16/7/2.
//  Copyright © 2016年 vanwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

//jsonString 与字典互转
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
+ (NSString *)objectToJson:(id)object;
//返回数组
+(NSMutableArray *)arrayWithJsonString:(NSString *)jsonString;

@end
