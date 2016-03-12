//
//  ViewController.m
//  HCProgressView
//
//  Created by suhc on 16/3/11.
//  Copyright © 2016年 kongjianjia. All rights reserved.
//

#import "ViewController.h"
#import "HCCircleView.h"
#import <HCTools/HCTools.h>

@interface ViewController ()
{
    HCCircleView *_circleView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _circleView = [[HCCircleView alloc] init];
    _circleView.frame = CGRectMake(0, 0, 200, 200);
    _circleView.center = CGPointMake(self.view.width * 0.5, 200);
    [self.view addSubview:_circleView];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.frame = CGRectMake(50, self.view.height - 200, self.view.width - 100, 30);
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)sliderValueChanged:(UISlider *)slider{
    _circleView.progress = slider.value;
}

/**
 *  学习渐变色
 */
- (void)studyGradientColor{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, 300, 300);
    view.center = self.view.center;
    [self.view addSubview:view];
    
    //渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //分段设置渐变色
    gradientLayer.frame = view.bounds;
    gradientLayer.locations = @[@0.3,@0.6,@1];
    gradientLayer.colors = @[(id)[UIColor lightGrayColor].CGColor,(id)[UIColor grayColor].CGColor,(id)[UIColor blackColor].CGColor];
    [view.layer addSublayer:gradientLayer];
}

/**
 *  学习UIBezierPath
 */
- (void)studyBezierPath{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, 300, 300);
    view.center = self.view.center;
    [self.view addSubview:view];
    
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    //设置shapeLayer的尺寸和位置
    shapeLayer.frame = view.bounds;
    //填充颜色为ClearColor
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = 10.f;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    //添加并显示
    [view.layer addSublayer:shapeLayer];
    
    /**
     现在我们要用到CAShapeLayer的两个参数，strokeEnd和strokeStart
     Stroke:用笔画的意思
     在这里就是起始笔和结束笔的位置
     Stroke为1的话就是一整圈，0.5就是半圈，0.25就是1/4圈。以此类推
     
     如果我们把起点设为0，终点设为0.75(逆时针)
     */
    shapeLayer.strokeStart = 0;
    
    shapeLayer.strokeEnd = 1;
}
/**
 先简单的介绍下CAShapeLayer
 1,CAShapeLayer继承自CALayer，可使用CALayer的所有属性
 2,CAShapeLayer需要和贝塞尔曲线配合使用才有意义。
 Shape：形状
 贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer是没有任何意义的。
 3,使用CAShapeLayer与贝塞尔曲线可以实现不在view的DrawRect方法中画出一些想要的图形
 
 关于CAShapeLayer和DrawRect的比较
 DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
 CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存
 
 贝塞尔曲线与CAShapeLayer的关系
 1，CAShapeLayer中shape代表形状的意思，所以需要形状才能生效
 2，贝塞尔曲线可以创建基于矢量的路径
 3，贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape
 4，用于CAShapeLayer的贝塞尔曲线作为Path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线
 */
@end
