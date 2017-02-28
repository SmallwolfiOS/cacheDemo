//
//  GD_LoginCoordinator.m
//  GoodPrincipal
//
//  Created by 李少峰 on 16/9/19.
//  Copyright © 2016年 马海平. All rights reserved.
//

#import "GD_LoginCoordinator.h"


@implementation GD_LoginCoordinator

- (void)requestPostCreateUserWithParamers:(NSDictionary *)paramers {
    self.tag = RequestCreate;
//    [self loadDataWithPostPath:registerUrl parameters:paramers];
}

- (void)requestPostTokenDataWithParamers:(NSDictionary *)paramers {
    self.tag = RequestToken;
//    [self loadDataWithPostPath:loginGetTokenUrl parameters:paramers];
}

- (void)requestGetUserInfoData {
    self.tag = RequestUserInfo;
//    [self loadDataWithGetPath:userInfoUrl];
}

- (void)processOriginalData:(id)data {
    switch (self.tag) {
        case RequestCreate:
        {
            [super processOriginalData:data];
        }
            break;
        case RequestToken:
        {
//            NSDictionary *dataDictionary = (NSDictionary *)data;
//            [GD_UserInfoModel loaginYXUser:[dataDictionary dsb_stringForKey:@"yx_accid"] token:[dataDictionary dsb_stringForKey:@"yx_token"]];
//            NSString *token = [dataDictionary dsb_stringForKey:UserToken];
//            BOOL init = [[dataDictionary dsb_stringForKey:Init] boolValue];
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setValue:token forKey:UserToken];
//            [userDefault setBool: init forKey:Init];
//            [userDefault synchronize];
//            [self performSelectorInBackground:@selector(getClassesandQiniu) withObject:nil];
//            [self requestGetUserInfoData];
        }
            break;
        case RequestUserInfo:
        {
            NSDictionary *dataDictionary = (NSDictionary *)data;
//            GD_UserInfoModel *item = [GD_UserInfoModel sharedInstance];
//            item = [GD_UserInfoModel modelWithJSON:dataDictionary];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setValue:dataDictionary forKey:UserInfoItem];
            [userDefault synchronize];
            if ([self.delegate respondsToSelector:@selector(coordinator:data:)]) {
                [self.delegate coordinator:self data:dataDictionary];
            }
        }
            break;
        default:
            break;
    }
}

@end
