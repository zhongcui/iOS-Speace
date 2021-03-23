//
//  STCircularProgress.m
//  STEnterprise
//
//  Created by mac on 2021/3/20.
//

#import "STCircularProgress.h"

@interface STCircularProgress()
{
    UIColor *_backColor;
    UIColor *_progressColor;
    CGFloat _lineWidth;
}

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property(nonatomic, strong) UILabel *progressNum;
@end

@implementation STCircularProgress

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
          lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _backColor = backColor;
        _lineWidth = lineWidth;
        [self addSubLayers];
    }
    return self;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    [self.layer addSublayer:self.progressLayer];
//    self.progressNum.textColor = progressColor;
}

-(void)addSubLayers
{
    [self.layer addSublayer:self.backgroundLayer];
    [self addSubview:self.progressNum];
}

-(CAShapeLayer *)backgroundLayer
{
    if(!_backgroundLayer)
    {
        float radius = 18;
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        _backgroundLayer = [self createRingLayerWithCenter:center radius:radius lineWidth:_lineWidth color:_backColor];
    }
    return _backgroundLayer;
}

-(CAShapeLayer *)progressLayer
{
    if(!_progressLayer)
    {
        float radius = 18;
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
        _progressLayer = [self createRingLayerWithCenter:center radius:radius lineWidth:_lineWidth color:_progressColor];
        _progressLayer.strokeEnd = 0; //CGFloat类型，[0,1] 表示画边线的起点和终点（即在路径上的百分比）
    }
    return _progressLayer;
}

- (CAShapeLayer *)createRingLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color
{
    UIBezierPath *smoothedPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:- M_PI_2 endAngle:(M_PI + M_PI_2) clockwise:YES];
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.contentsScale = [[UIScreen mainScreen] scale];
    slice.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    slice.fillColor = [UIColor clearColor].CGColor;
    slice.strokeColor = color.CGColor;
    slice.lineWidth = lineWidth;

    slice.path = smoothedPath.CGPath;
    return slice;
}

-(UILabel *)progressNum
{
    if (!_progressNum) {
        _progressNum = [[UILabel alloc]init];
        _progressNum.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _progressNum.font = [UIFont systemFontOfSize:14.f];
        _progressNum.textAlignment = NSTextAlignmentCenter;
        self.progressNum.textColor = _backColor;
    }
    return _progressNum;
}

- (void)setProgress:(int)progress
{
    self.progressLayer.strokeEnd = 1;
    self.progressNum.text = [NSString stringWithFormat:@"%d",progress];
}

@end
