//
//  STUserUnLoginHeader.h
//  STEnterprise
//
//  Created by mac on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface STUserUnLoginHeader : UIView
@property (nonatomic, strong) RACSubject *loginSubject;
@end

