//
//  ViewController2.m
//  SHA1Demo
//
//  Created by Jason on 2017/3/1.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ViewController2.h"
#import <AFNetworking.h>
@interface ViewController2 ()

@end
#define serverUrl           @"http://service.image.myqcloud.com"
@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    
    NSString * token = @"Mx4bV2AH9sQ/rJ+mME8P1B3bgQ1hPTEyNTE0MTQ0MTEmYj1vY3Imaz1BS0lEdjM2NGRkSDhYTnVWbUtLVEJJeEE4SjY2UUc4UXRPWTUmZT0xNDg4MzYwMTE4JnQ9MTQ4ODM1MDExOCZyPTM5MTkzMDU3MDEmdT0wJmY9";
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token] forHTTPHeaderField:@"Authorization"];
    NSDictionary *parameters = @{
                                 @"appid": @"1251414411",
                                 @"bucket": @"ocr",
                                 @"group_ids":@[@"tencent"],
                                 @"person_id":@"person0",
                                 @"url":@"http://ocr-1251414411.costj.myqcloud.com/IMG_0080.JPG",
                                 };
    
    [manager POST:@"/face/newperson" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            result = (NSDictionary *)responseObject;
        }else if([responseObject isKindOfClass:[NSData class]]){
            NSData *_data = responseObject;
            id _json = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
            result = [NSDictionary dictionaryWithDictionary:_json];
            NSLog(@"%@",result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
