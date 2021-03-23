//
//  NSString+BYValidate.h
//  STEnterprise
//
//  Created by mac on 2021/3/18.
//

#import <Foundation/Foundation.h>

@interface NSString (KooValidate)
/**
 *  检测字符串是否为手机号
 */
- (BOOL)isMobileNumber;

/**
 *  检测字符串是否为邮箱
 */
- (BOOL)isEmailString;

/**
 *  检测字符串是否为空
 */
- (BOOL)isBlankString;

/**
 *  检查字符串是否有效
*/
- (NSString *)isValidString;

/**
 *  检测用户名是否符合要求
 */
- (BOOL)isUserName;

/**
 *  检测字符串是否为身份证号
 */
- (BOOL)isIdentityCardNo;

/**
 *  检测用户密码是否符合要求
 */
- (BOOL)isPassword;

- (BOOL)isNumber;

/**
 *  检测字符串是否包含Emoji
 */
- (BOOL)isContainsEmoji;
/**
 *  检测字符串最后一位是否包含Emoji
 */
- (BOOL)isLastContainsEmoji;


@end
