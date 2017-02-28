////
////  GPBaseCoordinator.m
////  GoodParents
////
////  Created by 李少峰 on 16/8/25.
////  Copyright © 2016年 马海平. All rights reserved.
////
//
//#import "GDBaseCoordinator.h"
//
//@implementation GDBaseCoordinator
//
//#pragma mark - get
//- (void)loadDataWithGetPath:(NSString *)pathURL {
//    self.pathURL = pathURL;
//    [self loadDataWithGetPath:pathURL parameters:nil];
//}
//
//- (void)loadDataWithGetPath:(NSString *)path parameters:(NSDictionary *)parameters {
//    if ([self.delegate respondsToSelector:@selector(coordinatorBegainRequest)]) {
//        [self.delegate coordinatorBegainRequest];
//    }
//    [SVProgressHUD show];
//    [[NetworkSessionManager shareInstance] getPath:path parameters:parameters withBlock:^(NSDictionary *result, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(coordinatorEndRequest)]) {
//            [self.delegate coordinatorEndRequest];
//        }
//        if (error) {
//            //判断,无网络,访问超时等
//            if ([self.delegate respondsToSelector:@selector(coordinatorErrorWithIndicatorType:)]) {
//                [self.delegate coordinatorErrorWithIndicatorType:IndicatorTypeNoNetWork];
//            }
//        }else{
//            NSString *errcode = [result dsb_stringForKey:@"errcode"];
//            if (errcode.intValue == 0) {
//                debugLog(@"result ======== %@",result);
//                [SVProgressHUD dismiss];
//                [self processOriginalData:[result objectForKey:@"contents"]];
//            }else{
//                if (errcode && errcode.length) {
//                    if ([errcode isEqualToString:@"50001"]) {
//                        [SVProgressHUD showErrorWithStatus:@"创建失败"];
//                    }else if ([errcode isEqualToString:@"50002"]){
//                        [SVProgressHUD showErrorWithStatus:@"更新失败"];
//                    }else if ([errcode isEqualToString:@"50003"]){
//                        [SVProgressHUD showErrorWithStatus:@"删除失败"];
//                    }else if ([errcode isEqualToString:@"50006"]){
//                        [SVProgressHUD showErrorWithStatus:@"角色错误"];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"20001"]){
////                        [SVProgressHUD showErrorWithStatus:@"园所不存在"];
//                    }else if ([errcode isEqualToString:@"20002"]){
//                        [SVProgressHUD showErrorWithStatus:@"园所已经创建过了"];
//                    }else if ([errcode isEqualToString:@"20003"]){
//                        [SVProgressHUD showErrorWithStatus:@"班级不存在"];
//                    }else if ([errcode isEqualToString:@"20004"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色不存在"];
//                    }else if ([errcode isEqualToString:@"20005"]){
//                        [SVProgressHUD showErrorWithStatus:@"绑定班级失败"];
//                    }else if ([errcode isEqualToString:@"20006"]){
//                        [SVProgressHUD showErrorWithStatus:@"绑定园所失败"];
//                    }else if ([errcode isEqualToString:@"20007"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色地址不存在"];
//                    }else if ([errcode isEqualToString:@"20008"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色信息不存在"];
//                    }else if ([errcode isEqualToString:@"20009"]){
//                        [SVProgressHUD showErrorWithStatus:@"解绑园所失败"];
//                    }else if ([errcode isEqualToString:@"20010"]){
//                        [SVProgressHUD showErrorWithStatus:@"解绑班级失败"];
//                    }else if ([errcode isEqualToString:@"20011"]){
//                        [SVProgressHUD showErrorWithStatus:@"已绑定园所"];
//                    }else if ([errcode isEqualToString:@"20012"]){
//                        [SVProgressHUD showErrorWithStatus:@"已绑定班级"];
//                    }else if ([errcode isEqualToString:@"20013"]){
//                        [SVProgressHUD showErrorWithStatus:@"班级已毕业"];
//                    }else if ([errcode isEqualToString:@"20014"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请已经超时"];
//                    }else if ([errcode isEqualToString:@"20015"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请记录不存在"];
//                    }else if ([errcode isEqualToString:@"20016"]){
//                        [SVProgressHUD showErrorWithStatus:@"宝宝不在任何班级或园所下"];
//                    }else if ([errcode isEqualToString:@"20017"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户不能解绑该宝宝"];
//                    }else if ([errcode isEqualToString:@"20018"]){
//                        [SVProgressHUD showErrorWithStatus:@"换班失败"];
//                    }else if ([errcode isEqualToString:@"20019"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请频繁"];
//                    }else if ([errcode isEqualToString:@"20020"]){
//                        [SVProgressHUD showErrorWithStatus:@"宝宝不存在"];
//                    }else if ([errcode isEqualToString:@"20021"]){
//                        [SVProgressHUD showErrorWithStatus:@"动态类型错误"];
//                    }else if ([errcode isEqualToString:@"20027"]){
//                        [SVProgressHUD showErrorWithStatus:@"修改考勤记录失败"];
//                    }else if ([errcode isEqualToString:@"20043"]){
//                        [SVProgressHUD showErrorWithStatus:[result dsb_stringForKey:@"message"]];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"30002"]){
//                        //token 过期或者无效
//                        [self loadDataRefreshTokenWithPath:path parameters:parameters result:result];
//                    }else if ([errcode isEqualToString:@"30001"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
//                    }else if ([errcode isEqualToString:@"30007"]){
//                        [SVProgressHUD showErrorWithStatus:@"注册用户已经存在"];
//                    }else if ([errcode isEqualToString:@"30008"]){
//                        [SVProgressHUD showErrorWithStatus:@"手机号码不存在"];
//                    }else if ([errcode isEqualToString:@"30005"]){
//                        [SVProgressHUD showErrorWithStatus:@"无法找到用户数据"];
//                    }else if ([errcode isEqualToString:@"30004"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建Token失败"];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"40003"]){
//                        [SVProgressHUD showErrorWithStatus:@"没有权限"];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"60001"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建云信id失败"];
//                    }else if ([errcode isEqualToString:@"60002"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建云信群组失败"];
//                    }
//                    
//                    else{
//                        [SVProgressHUD showErrorWithStatus:@"未知错误!"];
//                    }
//                }else{
//                    [SVProgressHUD showErrorWithStatus:@"未知错误!"];
//                }
//                if ([self.delegate respondsToSelector:@selector(coordinatorErrorWithIndicatorType:)]) {
//                    [self.delegate coordinatorErrorWithIndicatorType:IndicatorTypeServeBad];
//                }
//            }
//        }
//    }];
//}
//
//#pragma mark - post
//- (void)loadDataWithPostPath:(NSString *)pathURL {
//    self.pathURL = pathURL;
//    [self loadDataWithPostPath:pathURL parameters:nil];
//}
//
//- (void)loadDataWithPostPath:(NSString *)path parameters:(NSDictionary *)parameters {
//    if ([self.delegate respondsToSelector:@selector(coordinatorBegainRequest)]) {
//        [self.delegate coordinatorBegainRequest];
//    }
//    [SVProgressHUD show];
//    [[NetworkSessionManager shareInstance] postPath:path parameters:parameters withBlock:^(NSDictionary *result, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(coordinatorEndRequest)]) {
//            [self.delegate coordinatorEndRequest];
//        }
//        if (error) {
//            //判断,无网络,访问超时等
//            if ([self.delegate respondsToSelector:@selector(coordinatorErrorWithIndicatorType:)]) {
//                [self.delegate coordinatorErrorWithIndicatorType:IndicatorTypeNoNetWork];
//            }
//            [SVProgressHUD showErrorWithStatus:@"服务器出错"];
//        }else{
//            NSString *errcode = [result dsb_stringForKey:@"errcode"];
//            if (errcode.intValue == 0) {
//                debugLog(@"result ======== %@",result);
//                [SVProgressHUD dismiss];
//                [self processOriginalData:[result objectForKey:@"contents"]];
//            }else{
//                if (errcode && errcode.length) {
//                    if ([errcode isEqualToString:@"50001"]) {
//                        [SVProgressHUD showErrorWithStatus:@"创建失败"];
//                    }else if ([errcode isEqualToString:@"50002"]){
//                        [SVProgressHUD showErrorWithStatus:@"更新失败"];
//                    }else if ([errcode isEqualToString:@"50003"]){
//                        [SVProgressHUD showErrorWithStatus:@"删除失败"];
//                    }else if ([errcode isEqualToString:@"50006"]){
//                        [SVProgressHUD showErrorWithStatus:@"角色错误"];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"20001"]){
////                        [SVProgressHUD showErrorWithStatus:@"园所不存在"];
//                    }else if ([errcode isEqualToString:@"20002"]){
//                        [SVProgressHUD showErrorWithStatus:@"园所已经创建过了"];
//                    }else if ([errcode isEqualToString:@"20003"]){
//                        [SVProgressHUD showErrorWithStatus:@"班级不存在"];
//                    }else if ([errcode isEqualToString:@"20004"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色不存在"];
//                    }else if ([errcode isEqualToString:@"20005"]){
//                        [SVProgressHUD showErrorWithStatus:@"绑定班级失败"];
//                    }else if ([errcode isEqualToString:@"20006"]){
//                        [SVProgressHUD showErrorWithStatus:@"绑定园所失败"];
//                    }else if ([errcode isEqualToString:@"20007"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色地址不存在"];
//                    }else if ([errcode isEqualToString:@"20008"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户角色信息不存在"];
//                    }else if ([errcode isEqualToString:@"20009"]){
//                        [SVProgressHUD showErrorWithStatus:@"解绑园所失败"];
//                    }else if ([errcode isEqualToString:@"20010"]){
//                        [SVProgressHUD showErrorWithStatus:@"解绑班级失败"];
//                    }else if ([errcode isEqualToString:@"20011"]){
//                        [SVProgressHUD showErrorWithStatus:@"已绑定园所"];
//                    }else if ([errcode isEqualToString:@"20012"]){
//                        [SVProgressHUD showErrorWithStatus:@"已绑定班级"];
//                    }else if ([errcode isEqualToString:@"20013"]){
//                        [SVProgressHUD showErrorWithStatus:@"班级已毕业"];
//                    }else if ([errcode isEqualToString:@"20014"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请已经超时"];
//                    }else if ([errcode isEqualToString:@"20015"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请记录不存在"];
//                    }else if ([errcode isEqualToString:@"20016"]){
//                        [SVProgressHUD showErrorWithStatus:@"宝宝不在任何班级或园所下"];
//                    }else if ([errcode isEqualToString:@"20017"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户不能解绑该宝宝"];
//                    }else if ([errcode isEqualToString:@"20018"]){
//                        [SVProgressHUD showErrorWithStatus:@"换班失败"];
//                    }else if ([errcode isEqualToString:@"20019"]){
//                        [SVProgressHUD showErrorWithStatus:@"邀请频繁"];
//                    }else if ([errcode isEqualToString:@"20020"]){
//                        [SVProgressHUD showErrorWithStatus:@"宝宝不存在"];
//                    }else if ([errcode isEqualToString:@"20030"]){
//                        [SVProgressHUD showErrorWithStatus:@"请勿重复评价"];
//                    }else if ([errcode isEqualToString:@"20035"]){
//                        [SVProgressHUD showErrorWithStatus:@"您不能给自己加分"];
//                    }else if ([errcode isEqualToString:@"20043"]){
//                        [SVProgressHUD showErrorWithStatus:[result dsb_stringForKey:@"message"]];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"30002"]){
//                        //token 过期或者无效
//                        [self loadDataRefreshTokenWithPath:path parameters:parameters result:result];
//                    }else if ([errcode isEqualToString:@"30001"]){
//                        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
//                    }else if ([errcode isEqualToString:@"30007"]){
//                        [SVProgressHUD showErrorWithStatus:@"注册用户已经存在"];
//                    }else if ([errcode isEqualToString:@"30008"]){
//                        [SVProgressHUD showErrorWithStatus:@"手机号码不存在"];
//                    }else if ([errcode isEqualToString:@"30005"]){
//                        [SVProgressHUD showErrorWithStatus:@"无法找到用户数据"];
//                    }else if ([errcode isEqualToString:@"30004"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建Token失败"];
//                    }
//                    else if ([errcode isEqualToString:@"40001"]){
//                        [SVProgressHUD showErrorWithStatus:@"请完善信息"];
//                    }
//                    else if ([errcode isEqualToString:@"40003"]){
//                        [SVProgressHUD showErrorWithStatus:@"没有权限"];
//                    }else if ([errcode isEqualToString:@"40002"]){
//                        [SVProgressHUD showErrorWithStatus:@"参数不合法"];
//                    }
//                    
//                    else if ([errcode isEqualToString:@"60001"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建云信id失败"];
//                    }else if ([errcode isEqualToString:@"60002"]){
//                        [SVProgressHUD showErrorWithStatus:@"创建云信群组失败"];
//                    }
//                    
//                    else{
//                        [SVProgressHUD showErrorWithStatus:@"未知错误!"];
//                    }
//                }else{
//                    [SVProgressHUD showErrorWithStatus:@"未知错误!"];
//                }
//                if ([self.delegate respondsToSelector:@selector(coordinatorErrorWithIndicatorType:)]) {
//                    [self.delegate coordinatorErrorWithIndicatorType:IndicatorTypeServeBad];
//                }
//            }
//        }
//    }];
//}
//
//#pragma mark - 获取到数据 回调
//- (void)processOriginalData:(id)data {
//    if ([self.delegate respondsToSelector:@selector(coordinator:data:)]) {
//        [self.delegate coordinator:self data:data];
//    }
//}
//
//#pragma mark - token过期或者无效 需要刷新token
//- (void)loadDataRefreshTokenWithPath:(NSString *)path parameters:(NSDictionary *)parameters result:(NSDictionary *)result {
//    NSInteger token_ttl = [result[@"contents"] dsb_integerForKey:@"token_ttl"];
//    NSInteger refresh_ttl = [result[@"contents"] dsb_integerForKey:@"refresh_ttl"];
//    if (token_ttl < refresh_ttl) {
//        [SVProgressHUD showErrorWithStatus:@"登录令牌过期,请刷新令牌"];
//        [[NetworkSessionManager shareInstance] postPath:refreshTokenUrl parameters:nil withBlock:^(NSDictionary *result, NSError *error) {
//            if (error) {
//                //判断,无网络,访问超时等
//            }else {
//                NSString *errcode = [result dsb_stringForKey:@"errcode"];
//                NSString *token = [result[@"contents"] dsb_stringForKey:@"token"];
//                if (errcode.intValue == 0 && token) {
//                    [SVProgressHUD showErrorWithStatus:@"登录令牌刷新成功"];
//                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                    [userDefault setValue:token forKey:@"token"];
//                    [userDefault synchronize];
//                    [self loadDataWithGetPath:path parameters:parameters];
//                }else{
//                    [SVProgressHUD showErrorWithStatus:@"登录令牌刷新失败"];
//                }
//            }
//        }];
//    }else {
//#warning 此处应退出登录,弹出登录界面
//        [SVProgressHUD showErrorWithStatus:@"登录令牌失效,请重新登录"];
//        
//    }
//}
//
//@end
