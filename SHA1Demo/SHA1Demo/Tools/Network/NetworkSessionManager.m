//
//  NetworkSessionManager.m
//  zhefengle
//
//  Created by 橙子 on 15/11/12.
//  Copyright © 2015年 vanwell. All rights reserved.
//

#import "NetworkSessionManager.h"
#import "UIProgressView+AFNetworking.h"
#import "AppDelegate.h"
//#import "NSString+MD5.h"
//#import "SystemUtil.h"
#define kHttpCer            @"developmentCacert"
@implementation NetworkSessionManager

#define SuccessStateCode 0

static NetworkSessionManager *shareInstance = nil;

+ (NetworkSessionManager *)shareInstance{
    
    static NetworkSessionManager *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[NetworkSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://service.image.myqcloud.com/ocr/idcard"]];
    });
    return _shareInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
#warning 这里用的http,上线前转成https
//        AFSecurityPolicy *securityPolicy = [self customSecurityPolicy];
//        self.securityPolicy = securityPolicy;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (AFSecurityPolicy *)customSecurityPolicy
{
    /**** SSL Pinning ****/
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kHttpCer ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //  自签名证书设为YES 生产X.509证书设置为NO
    [securityPolicy setAllowInvalidCertificates:YES];
    NSSet *cerSet = [NSSet setWithObjects:certData, nil];
    [securityPolicy setPinnedCertificates:cerSet];
    /**** SSL Pinning ****/
    
    return securityPolicy;
}


- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *, NSError *))block{
//    NSDictionary *processDictionary = [self getProcessedParameter:parameters];
    
    [[NetworkSessionManager shareInstance] GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = (NSDictionary *)responseObject;
        }else if([responseObject isKindOfClass:[NSData class]]){
            NSData *_data = responseObject;
            id _json = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
            result = [NSDictionary dictionaryWithDictionary:_json];
        }
        if (block) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block([NSDictionary dictionary],error);
//            debugLog(@"error = %@",error);
        }
    }];
}


- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters withBlock:(void (^)(NSDictionary *, NSError *))block{
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
//    debugLog(@"jsonDataError==%@",error);
//    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSDictionary *processDictionary = [self getProcessedParameter:parameters];
    
    [[NetworkSessionManager shareInstance] POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = (NSDictionary *)responseObject;
        }else if([responseObject isKindOfClass:[NSData class]]){
            NSData *_data = responseObject;
            id _json = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
            result = [NSDictionary dictionaryWithDictionary:_json];
        }
        if (block) {
            block(result,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block([NSDictionary dictionary],error);
//            debugLog(@"error = %@",error);
        }
    }];
}


//对错误信息的处理
- (NSError *)errorAction:(NSError *)error{
    
    if (error.code == 401) {
        
        return nil;
    }else{
        return error;
    }
}

//添加所有接口的公共参数
//- (NSDictionary *)getProcessedParameter:(NSDictionary *)process{
//    NSMutableDictionary *beforeProcess = [[NSMutableDictionary alloc]initWithDictionary:process];
////    User *user = [User Instance];
////    if ([user getUserInfo]) {
////        [beforeProcess setValue:[user getToken] forKey:@"token"];
////        [beforeProcess setValue:[user getUserId] forKey:@"userId"];
////    }
//    NSDate *currentTime = [NSDate date];
//    NSString *currentTimeInerval = [NSString stringWithFormat:@"%ld",(long)[currentTime timeIntervalSince1970]];
//    [beforeProcess addEntriesFromDictionary:@{@"t":currentTimeInerval,
//                                              @"s":@"2",
//                                              @"v":kAppBundleValue,
//                        @"sign":@"5f4d6c5735244ef3a02f2746e361c825"
//                                              }];
//    
//    NSArray *keyArrayBeforeSort = [NSArray arrayWithArray:[beforeProcess allKeys]];
//    NSArray *keyArrayAfterSort = [keyArrayBeforeSort sortedArrayUsingSelector:@selector(compare:)];
//    NSMutableString *fullPatameter = [[NSMutableString alloc]init];
//    for (NSInteger i = 0; i < [keyArrayAfterSort count]; i++) {
//        NSString *key = keyArrayAfterSort[i];
//        NSString *value = [beforeProcess objectForKey:key];
//        if (i == [[beforeProcess allKeys] count] -1) {
//            [fullPatameter appendFormat:@"%@=%@",key,value];
//        }else{
//            [fullPatameter appendFormat:@"%@=%@&",key,value];
//        }
//    }
//    NSString *md5String = [fullPatameter MD5];
//    [beforeProcess setValue:md5String forKey:@"sign"];
//    return beforeProcess;
//}


@end
