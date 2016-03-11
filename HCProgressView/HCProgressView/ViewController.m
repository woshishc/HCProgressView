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

@end
