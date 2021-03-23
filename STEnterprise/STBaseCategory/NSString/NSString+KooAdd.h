//
//  NSString+KooAdd.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KooAdd)

/**
 根据字体计算字符串的大小
 @param font 字体类型
 @return 计算后的大小
 */
- (CGSize)stringSizeWithFont:(UIFont *)font;

/**
 MD5加密字符串
 @return 加密好的字符串
 */
- (NSString *)MD5String;

/**
 返回字符串的第一个大写首字母，如果没有返回#
 */
- (NSString *)firstCapitalChar;

- (NSArray *)getRangesStr:(NSString *)findText;

/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;

- (BOOL)containChinese:(NSString *)str;

/**
 根据字符的高度计算宽度
 
 @param text 文字
 @param height 高度
 @param font 字体大小
 @return 高度
 */
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

@end

NS_ASSUME_NONNULL_END
