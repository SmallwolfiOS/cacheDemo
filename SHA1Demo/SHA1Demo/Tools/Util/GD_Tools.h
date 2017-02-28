//
//  GD_GDTools.h
//  GoodPrincipal
//
//  Created by 李少峰 on 2016/10/17.
//  Copyright © 2016年 马海平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GD_Tools : NSObject


/// 缩短数量描述，例如 51234 -> 5万
+ (NSString *)shortedNumberDesc:(NSUInteger)number;


/**
 *  //按宽度压缩图片!
 *
 *  @param sourceImage 源image
 *  @param defineWidth 宽度
 *
 *  @return 修改过的图片
 */
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;



/**
 *  将图片进行base64编码
 *
 *  @param imageBeforeCompress 编码前的图片
 *
 *  @return 编码后的字符串
 */
+ (NSString *)getCompressAndBase64EncodeWithImage:(UIImage *)imageBeforeCompress;

/**
 *  微信分享链接,得到小于32k的图片.
 *
 *  @param imageBeforeCompress 压缩前的图片
 *
 *  @return 压缩后的图片.如果为nil,表示压缩失败.
 */
+ (UIImage *)getCompressUnder32KBImage:(UIImage *)imageBeforeCompress;

/**
 *  得到小于imageSize kb的图片.
 *
 *  @param imageSize           imageSize
 *  @param imageBeforeCompress imageBeforeCompress
 *
 *  @return return value description
 */
+ (UIImage *)getCompressUnder:(NSInteger)imageSize KBImage:(UIImage *)imageBeforeCompress;

/**
 判断手机号的正则表达式

 @param mobile 传入的手机号字符串
 @return 是否是符合标准的手机号
 */
+ (BOOL)valiMobile:(NSString *)mobile;



/// 获取富文本attributedText  改变range范围的color
+ (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text Color:(UIColor *)color Range:(NSRange)range;


/// 动态类型描述
+ (NSString *)dynamicTypeDescWithType:(int32_t)type;


@end
