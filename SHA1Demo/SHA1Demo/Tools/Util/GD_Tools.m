//
//  GD_GDTools.m
//  GoodPrincipal
//
//  Created by 李少峰 on 2016/10/17.
//  Copyright © 2016年 马海平. All rights reserved.
//

#import "GD_Tools.h"
#import "UIKitUtil.h"
@implementation GD_Tools


+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    // should be localized
    if (number <= 9999) return [NSString stringWithFormat:@"加分%d", (int)number];
    if (number <= 9999999) return [NSString stringWithFormat:@"加分%d万", (int)(number / 10000)];
    return [NSString stringWithFormat:@"加分%d千万", (int)(number / 10000000)];
}


//按宽度压缩图片!
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight+1;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
//        debugLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


+ (NSString *)getCompressAndBase64EncodeWithImage:(UIImage *)imageBeforeCompress
{
    //压缩图片
    UIImage *imageAfterCompress = [GD_Tools imageCompressForWidth:imageBeforeCompress targetWidth:640.f];
//    debugLog(@"图像长和宽%@",NSStringFromCGSize(imageAfterCompress.size));
    NSData *imageDataBf = UIImageJPEGRepresentation(imageAfterCompress, 0.3);
//    debugLog(@"图片data长度:%lu",(unsigned long)imageDataBf.length);
    //base64编码
    NSString *imageDataAf = [imageDataBf base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return [NSString stringWithFormat:@"data:image/jpeg;base64,%@",imageDataAf];
}

+ (UIImage *)getCompressUnder32KBImage:(UIImage *)imageBeforeCompress
{
    UIImage *tempImage = imageBeforeCompress;
    CGFloat compressPoint = 1.0f;
    NSData *imageData = UIImageJPEGRepresentation(imageBeforeCompress, compressPoint);
    NSInteger i = 0;
    while (imageData.length/1024 >= 32) {
        imageData = nil;
        tempImage = nil;
        compressPoint -= 0.1f;
        if (compressPoint < 0) {
            compressPoint = 0.5f;
        }
        imageData = UIImageJPEGRepresentation(imageBeforeCompress, compressPoint);
        tempImage = [[UIImage alloc]initWithData:imageData];
        if (compressPoint == 0) {
            break;
        }
        i++;
        if (i == 5) {
            break;
        }
    }
    if (imageData.length/1024 >= 32) {
        return nil;
    }
    return tempImage;
}

+ (UIImage *)getCompressUnder:(NSInteger)imageSize KBImage:(UIImage *)imageBeforeCompress
{
    UIImage *tempImage = imageBeforeCompress;
    CGFloat compressPoint = 1.0f;
    NSData *imageData = UIImageJPEGRepresentation(imageBeforeCompress, compressPoint);
    while (imageData.length/1024 >= imageSize) {
        imageData = nil;
        tempImage = nil;
        compressPoint -= 0.1f;
        imageData = UIImageJPEGRepresentation(imageBeforeCompress, compressPoint);
        //debugLog(@"%lu",imageData.length/1024);
        tempImage = [[UIImage alloc]initWithData:imageData];
        if (compressPoint == 0) {
            break;
        }
    }
    if (imageData.length/1024 >= imageSize) {
        return nil;
    }
    return tempImage;
}
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(173)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}


+ (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text Color:(UIColor *)color Range:(NSRange)range {
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:text];
    [contentString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return contentString;
}

// 发布的动态类型,1动态 2通知 3食谱 4亲子共习(作业)
+ (NSString *)dynamicTypeDescWithType:(int32_t)type {
    NSString *typeStr = @"动态";
    switch (type) {
        case 1:
            typeStr = @"动态";
            break;
        case 2:
            typeStr = @"通知";
            break;
        case 3:
            typeStr = @"食谱";
            break;
        case 4:
            typeStr = @"作业";
            break;
        default:
            typeStr = @"";
            break;
    }
    return typeStr;
}

@end
