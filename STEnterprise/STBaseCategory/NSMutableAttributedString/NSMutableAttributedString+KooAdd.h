//
//  NSMutableAttributedString+Cate.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (KooAdd)

- (NSMutableAttributedString *)appendStr:(NSString *)str font:(UIFont *)font textColor:(UIColor *)color lineColor:(UIColor *)lineColor;

- (NSMutableAttributedString *)appendStr:(NSString *)str font:(UIFont *)font textColor:(UIColor *)color lineSpacing:(CGFloat)line;

- (NSMutableAttributedString *)appendStr:(NSString *)str font:(UIFont *)font textColor:(UIColor *)color;

- (NSMutableAttributedString *)appendStr:(NSString *)str;

- (NSMutableAttributedString *)addBgColor:(UIColor *)color range:(NSRange)range;

- (NSMutableAttributedString *)koo_setLineSpacing:(CGFloat)line;

- (CGSize)sizeWithWidth:(CGFloat)width;

- (CGSize)sizeWithHeight:(CGFloat)height;

@end
