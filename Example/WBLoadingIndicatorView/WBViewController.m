//
//  WBViewController.m
//  WBLoadingIndicatorView
//
//  Created by wenmobo on 09/07/2018.
//  Copyright (c) 2018 wenmobo. All rights reserved.
//

#import "WBViewController.h"
#import <WBLoadingIndicatorView/WBLoadingIndicatorView.h>

@interface WBViewController () <UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation WBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

// MARK:UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:kIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.typeArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {//contentColor
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view];
            indicatorView.type = WBLoadingAnimationcircleStrokeSpinType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor redColor];
            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
            indicatorView.bezelView.blurEffectStyle = UIBlurEffectStyleLight;
        }
            break;
        case 1:
        {//indicatorSize
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view];
            indicatorView.type = WBWBLoadingAnimationBallPulseType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor whiteColor];
//            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
            indicatorView.indicatorSize = CGSizeMake(60, 60);
        }
            break;
        case 2:
        {//to window
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view];
            indicatorView.type = WBWBLoadingAnimationBallClipRotateType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor whiteColor];
            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
            
        }
            break;
        case 3:
        {
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view.window];
            indicatorView.type = WBWBLoadingAnimationBallClipRotatePulseType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor whiteColor];
            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hideIndicator];
            });
        }
            break;
        case 4:
        {
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view];
            indicatorView.type = WBWBLoadingAnimationBallClipRotateMultipleType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor whiteColor];
//            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
        }
            break;
        case 5:
        {
            WBLoadingIndicatorView *indicatorView = [self createIndicatorViewWithType:WBWBLoadingAnimationBallTrianglePathType
                                                                        indicatorSize:CGSizeMake(50, 50)
                                                                               toView:self.view];
            indicatorView.type = WBWBLoadingAnimationBallTrianglePathType;
            indicatorView.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
            indicatorView.contentColor = [UIColor whiteColor];
//            indicatorView.bezelView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7f];
        }
            break;
        default:
            break;
    }
}

- (WBLoadingIndicatorView *)createIndicatorViewWithType:(WBLoadingAnimationType)type
                                          indicatorSize:(CGSize)indicatorSize
                                                 toView:(UIView *)view {
    WBLoadingIndicatorView *indicatorView = [WBLoadingIndicatorView wb_showIndicatorAddTo:view];
    indicatorView.type = type;
    indicatorView.label.text = @"   加载中...";
    indicatorView.indicatorSize = indicatorSize;
    return indicatorView;
}

- (void)hideIndicator {
    WBLoadingIndicatorView *indicatorView1 = [WBLoadingIndicatorView wb_indicatorForView:self.view];
    [indicatorView1 wb_hideLoadingView:YES];
    
    WBLoadingIndicatorView *indicatorView2 = [WBLoadingIndicatorView wb_indicatorForView:self.view.window];
    [indicatorView2 wb_hideLoadingView:YES];
}

- (IBAction)hide:(id)sender {
    [self hideIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK:Getter
- (NSArray *)typeArray {
    if (!_typeArray) {
        _typeArray = @[@"WBLoadingAnimationcircleStrokeSpinType",
                       @"WBWBLoadingAnimationBallPulseType",
                       @"WBWBLoadingAnimationBallClipRotateType",
                       @"WBWBLoadingAnimationBallClipRotatePulseType",
                       @"WBWBLoadingAnimationBallClipRotateMultipleType",
                       @"WBWBLoadingAnimationBallTrianglePathType"];
    }
    return _typeArray;
}

@end
