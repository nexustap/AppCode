overview
========
锦里的IOS应用，主要功能是资讯、活动、圈子、通讯录、聊天等。

##1. 工程安装说明

### 1.1 CocoaPods安装

如果你没有安装CocoaPods，先行安装。已经安装过的人，跳过此步骤。

```
sudo gem install cocoapods
```

### 1.2 CocoaPods配置

编辑Podfile文件，根据需求编写。本工程已经填写，请根据实际需求添加内容

```
platform :ios
pod 'JSONKit',       '~> 1.4'
pod 'Reachability',  '~> 3.0.0'
```

在工程内安装cocoaPods。本工程已经安装上，一般忽略此步骤。重新安装或者没有下载pods工程，需要此步骤。
```
pod install
```

在工程内升级库包。如果修改了Podfile文件，增加了新的配置，那么根据实际需求执行此步骤。
```
pod update
```

### 1.3 打开工程
```
open jinli.xcworkspace
```
