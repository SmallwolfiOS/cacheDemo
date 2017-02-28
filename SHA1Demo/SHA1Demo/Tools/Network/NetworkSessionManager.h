//
//  NetworkSessionManager.h
//  zhefengle
//
//  Created by 橙子 on 15/11/12.
//  Copyright © 2015年 vanwell. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkSessionManager : AFHTTPSessionManager

+ (NetworkSessionManager *)shareInstance;

/**
 *  get请求
 *
 *  @param path       url路径
 *  @param parameters 参数
 *  @param block      block
 */
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *result, NSError *error))block;

/**
 *  post请求
 *
 *  @param path       url路径
 *  @param parameters 参数
 *  @param block      block
 */
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *result, NSError *error))block;




@end
