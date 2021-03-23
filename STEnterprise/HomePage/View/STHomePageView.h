//
//  STHomePageView.h
//  STEnterprise
//
//  Created by mac on 2021/3/19.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface STHomePageView : UIView
@property (nonatomic, strong) RACSubject *billSubject;  //运单
@property (nonatomic, strong) RACSubject *paySubject;   //支付
@property (nonatomic, strong) RACSubject *invoiceSubject;//开票
@property (nonatomic, strong) RACSubject *lineSubject;  //线路
@property (nonatomic, strong) RACSubject *msgSubject;   //信息
@property (nonatomic, strong) RACSubject *carSubject;   //车辆
@end

