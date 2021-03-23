//
//  STDispatchCell.h
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import <UIKit/UIKit.h>

@interface STDispatchCell : UITableViewCell
+ (NSString *)identifier;
-(void)setCellImgNamed:(NSString *)name title:(NSString *)title detail:(NSString *)detail;
@end

