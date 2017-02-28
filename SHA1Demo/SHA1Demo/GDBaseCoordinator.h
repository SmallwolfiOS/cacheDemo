//
//  GPBaseCoordinator.h
//  GoodParents
//
//  Created by 李少峰 on 16/8/25.
//  Copyright © 2016年 马海平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkSessionManager.h"
#import "SVProgressHUD.h"
//#import "UIScrollView+EmptyDataSet.h"

@class GDBaseCoordinator;
@protocol GDCoordinatorDelegate <NSObject>

@optional
- (void)coordinatorBegainRequest;
- (void)coordinatorEndRequest;
- (void)coordinator:(GDBaseCoordinator *)coordinator data:(id)data;
//- (void)coordinatorErrorWithIndicatorType:(IndicatorType)indicatorType;
//- (void)coordinatorLoadedAllData;
@end

@interface GDBaseCoordinator : NSObject

@property (weak, nonatomic) id<GDCoordinatorDelegate> delegate;
@property (strong, nonatomic) NSString *pathURL;
@property (assign, nonatomic) NSInteger tag;

- (void)loadDataWithGetPath:(NSString *)pathURL;
- (void)loadDataWithGetPath:(NSString *)pathURL parameters:(NSDictionary *)parameters;

- (void)loadDataWithPostPath:(NSString *)pathURL;
- (void)loadDataWithPostPath:(NSString *)pathURL parameters:(NSDictionary *)parameters;

/**
 *  处理网络返回的数据，需要子类来重写
 *
 *  @param data 源数据
 */
- (void)processOriginalData:(id)data;

@end
