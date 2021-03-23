//
//  UIColor+KooAdd.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <UIKit/UIKit.h>

@interface UIColor (KooAdd)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  @brief  渐变颜色
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *  从左到右渐变 如果需要从上到下 宽高反着传值即可
 *  @return 渐变颜色
 */
+ (UIColor*)koo_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height withWidth:(CGFloat)width;
@end
