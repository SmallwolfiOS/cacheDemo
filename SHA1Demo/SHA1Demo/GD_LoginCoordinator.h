//
//  GD_LoginCoordinator.h
//  GoodPrincipal
//
//  Created by 李少峰 on 16/9/19.
//  Copyright © 2016年 马海平. All rights reserved.
//

#import "GDBaseCoordinator.h"

typedef NS_ENUM(NSInteger,LoginRequestType) {
    RequestCreate   = 1,        // 创建账户
    RequestToken    = 2,        // 获取用户token
    RequestUserInfo = 3,        // 获取用户信息
};

@interface GD_LoginCoordinator : GDBaseCoordinator

/**
 * 注册成功后,该通行证可以登录家长端 老师端 和 园长端.注册到时候不需要制定具体到角色.
 * 传入注册帐号,规定为手机号码 和 登录密码
 */
- (void)requestPostCreateUserWithParamers:(NSDictionary *)paramers;

/**
 * 登录账户密码获取用户token  然后获取登录用户的个人信息
 * 传入个人账户和密码
 */
- (void)requestPostTokenDataWithParamers:(NSDictionary *)paramers;

/**
 * 获取用户信息（已有有效token）
 */
- (void)requestGetUserInfoData;

@end
