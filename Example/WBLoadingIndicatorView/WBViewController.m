//
//  WBViewController.m
//  WBLoadingIndicatorView
//
//  Created by wenmobo on 09/07/2018.
//  Copyright (c) 2018 wenmobo. All rights reserved.
//

#import "WBViewController.h"
#import <WBLoadingIndicatorView/WBLoadingIndicatorView.h>

@interface WBViewController ()
{
    WBLoadingIndicatorView *view;
}
@end

@implementation WBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    view = [WBLoadingIndicatorView wb_showIndicatorAddTo:self.view];
    view.label.text = @"   加载中...";
    view.type = WBWBLoadingAnimationBallTrianglePathType;
    view.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
    view.bezelView.backgroundColor = [UIColor orangeColor];
    view.indicatorSize = CGSizeMake(50, 50);
//    view.minSize = CGSizeMake(200, 200);
//    hud.contentColor = [UIColor redColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [view wb_hideLoadingView:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
