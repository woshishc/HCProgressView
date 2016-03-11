//
//  CircleView.m
//  HCProgressView
//
//  Created by suhc on 16/3/11.
//  Copyright © 2016年 kongjianjia. All rights reserved.
//

#import "HCCircleView.h"
#import <HCTools/HCTools.h>

@interface HCCircleView ()
{
    CAShapeLayer *_progressLayer;
    
    UILabel *_dataLabel;
}
@end
@implementation HCCircleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dataLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _dataLabel.bounds = CGRectMake(0, 0, 90, 30);
    _dataLabel.center = self.center;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    _progressLayer.opacity = 0;
    _dataLabel.text = [NSString stringWithFormat:@"%.2f%%",_progress * 100];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self drawGradientCircleWithRect:rect];
}

/**
 *  画出无渐变色圆环
 */
- (void)drawPureColorCircleWithRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //线条宽度
    CGFloat lineWidth = 10;
    //设置圆心位置
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //设置半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - lineWidth * 0.5;
    //圆起点位置
    CGFloat startA = -M_PI_2;
    //圆终点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;
    
    //最后一个参数为YES代表逆时针绘制，为NO代表顺时针绘制
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    //设置线条宽度
    CGContextSetLineWidth(ctx, lineWidth);
    //设置描边颜色
    [[UIColor blueColor] set];
    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //渲染
    CGContextStrokePath(ctx);
}

/**
 *  画出带渐变色的圆环
 */
- (void)drawGradientCircleWithRect:(CGRect)rect{
    //线条宽度
    CGFloat lineWidth = 10;
    //设置圆心位置
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //设置半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5 - lineWidth * 0.5;
    //圆起点位置
    CGFloat startA = -M_PI_2;
    //圆终点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;
    
    //获取环形路径(画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形)
    _progressLayer = [CAShapeLayer layer];
    //创建一个track shape layer
    _progressLayer.frame = self.bounds;
    //填充色为无色
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    //制定path的渲染颜色，这里可以设置任意不透明颜色
    _progressLayer.strokeColor = [UIColor redColor].CGColor;
    //背景颜色的透明度
    _progressLayer.opacity = 1;
    //指定线的边缘是圆的
    _progressLayer.lineCap = kCALineCapRound;
    //线的宽度
    _progressLayer.lineWidth = lineWidth;
    
    //最后一个参数为YES代表逆时针绘制，为NO代表顺时针绘制
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //把path传递给layer，然后layer会处理对应的渲染，整个逻辑和CoreGraph是一致的
    _progressLayer.path = path.CGPath;
    
    [self.layer addSublayer:_progressLayer];
    
    //生成渐变色层
    CALayer *gradientLayer = [self createGradientLayer];
    //用progressLayer来截取渐变层
    [gradientLayer setMask:_progressLayer];
    
    [self.layer addSublayer:gradientLayer];
}

/**
 *  生成渐变色层
 */
- (CALayer *)createGradientLayer{
    //生成渐变色
    CALayer *gradientLayer = [CALayer layer];
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    //分段设置渐变色
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width * 0.5, self.bounds.size.height);
    leftLayer.locations = @[@0.3,@0.9,@1];
    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];
    [gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    //分段设置渐变色
    rightLayer.frame = CGRectMake(self.bounds.size.width * 0.5, 0, self.bounds.size.width * 0.5, self.bounds.size.height);
    rightLayer.locations = @[@0.3,@0.9,@1];
    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor];
    [gradientLayer addSublayer:rightLayer];
    
    return gradientLayer;
}

@end
