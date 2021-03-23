//
//  STCircularProgress.h
//  STEnterprise
//
//  Created by mac on 2021/3/20.
//

#import <UIKit/UIKit.h>


@interface STCircularProgress : UIView
- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
          lineWidth:(CGFloat)lineWidth;

- (void)setProgress:(int)progress;

-(void)setProgressColor:(UIColor *)progressColor;

@end

