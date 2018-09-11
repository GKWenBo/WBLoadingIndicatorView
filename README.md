# WBLoadingIndicatorView

<p align="left">
<a href="https://travis-ci.org/wenmobo/WBLoadingIndicatorView"><img src="https://travis-ci.org/wenmobo/WBLoadingIndicatorView.svg?style=flat?branch=master"></a>
<a href="https://travis-ci.org/wenmobo/WBLoadingIndicatorView"><img src="https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=flatt"></a>
<a  href="https://cocoapods.org/pods/WBLoadingIndicatorView"><img src ="https://img.shields.io/cocoapods/v/WBLoadingIndicatorView.svg?style=flat"> </a>
<a  href="https://cocoapods.org/pods/WBLoadingIndicatorView"><img src ="https://img.shields.io/packagist/l/doctrine/orm.svg?style=flat"> </a>
<a  href="https://cocoapods.org/pods/WBLoadingIndicatorView"><img src ="https://img.shields.io/cocoapods/p/WBLoadingIndicatorView.svg?style=flat"> </a>
<a  href="https://cocoapods.org/pods/WBLoadingIndicatorView"><img src ="https://img.shields.io/badge/language-objctive--c-red.svg?style=flat"> </a>
</p>

## 中文说明

<figure class="third">
<img src="https://ws2.sinaimg.cn/large/0069RVTdly1fv5vfzum5xg308p0i2aak.gif" width="200"><img src="https://ws4.sinaimg.cn/large/0069RVTdly1fv5vhwysnfg308p0i2dgd.gif" width="200"><img src="https://ws4.sinaimg.cn/large/0069RVTdly1fv5vw05y8cg308p0i2wf5.gif" width="200"><img src="https://ws1.sinaimg.cn/large/0069RVTdly1fv5vwliqtyg308p0i276d.gif" width="200">
</figure>

基于CALayer封装加载等待动画，目前支持6种类型动画：
```
typedef NS_ENUM(NSInteger, WBLoadingAnimationType) {
WBLoadingAnimationcircleStrokeSpinType,
WBWBLoadingAnimationBallPulseType,
WBWBLoadingAnimationBallClipRotateType,
WBWBLoadingAnimationBallClipRotatePulseType,
WBWBLoadingAnimationBallClipRotateMultipleType,
WBWBLoadingAnimationBallTrianglePathType
};
```

## Requirements

- iOS 8+
- Xcode 8+

## Installation

### Cocoapods安装

WBLoadingIndicatorView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WBLoadingIndicatorView'
```

### 手动安装

将**WBLoadingIndicatorView**文件夹拖入工程即可。

## Usage
具体效果与使用，请查看demo.

## Author

author：wenbo    
QQ：1050794513  
email：1050794513@qq.com

## 更新

  > - 2018-09-11 （1.0.1）：添加背景模糊效果

## License

WBLoadingIndicatorView is available under the MIT license. See the LICENSE file for more info.
