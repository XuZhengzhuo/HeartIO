# HeartIO
Swift Login interface , draw in UIView and AFNetwork.

## 1. APP设计
### 1.1 UI设计
#### 1.1.1 登录界面

简洁直观的登录界面可以消除信息干扰，提升用户体验，让用户切实地体会到愉悦感。本着简单的原则，我们在登录界面仅考虑了关键元素。
当输入用户名时，如果缓存中已经存在此用户的信息（之前登录过），则会自动调取用户头像，并将头像处理作为登录背景，美化界面的同时给到用户真实的反馈。

![](https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/log1.jpg)
![](https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/log2.jpg)
<div align="center">
<img src="https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/log1.jpg" height="500px" alt="" >
<img src="https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/log2.jpg" height="500px" alt="" >
</div>

#### 1.1.2 信息界面

信息界面即主界面，我们在此界面展示所有需要的信息。本着一贯的设计风格，用最简洁最直接的方式表达尽可能多的信息。同时，尽量减少用户需要的操作，所有的信息获取在一步动作（点击、滑动等）以内可获得。

顶部使用了自定义的导航栏。左边的返回按钮即为退出当前页面，右侧的图片指示当前的登录用户。

中部为主要信息展示区。使用了UISegmentedControl()控件，使得显示区域得到复用。“今日”栏目显示实时心跳数据，数据每秒刷新一次，绘制成折线图，更加形象直观。“本周”栏目展示最近一周的平均数值，可以借此评估用户的活动频率和健康状态。

底部为异常信息记录区。使用了UITableView()控件，展示历史上出现异常数据的时间和可能原因，提醒用户注意身体。

<div align="center">
<img src="https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/main1.png" height="500px" alt="" >
<img src="https://github.com/XuZhengzhuo/HeartIO/blob/master/readme_image/main2.jpg" height="500px" alt="" >
</div>

### 1.2 架构设计


架构设计遵循Apple Design要求，使用AutoLayout自动布局，可适用所有iOS设备。数据全部保存在云端，减小了APP的体积。


#### 1.2.1 主要创建和复写的类

|类名	|功能|
|  ----  | ----  |
|class ViewController: UIViewController	|登录界面|
|class HeartViewController: UIViewController	|信息界面|
|Alamofire.swift	|网络调用|
|class HeartState: UIView	|重写UIView实现画图功能|
|class TerminalCell: UITableViewCell	|自定义列表cell格式|
|class infomation	|主要处理的数据结构样式|

### 1.2.2 主要控件

| 控件名 | 实例化 |
|  ----  | ----  |
|UIView	|SplitLineView、NavView、FirstView、SecondView|
|UIImageView|	CoverImageView、UserInfoImageView|
|UITextField|	UserNameTextField、PasswordTextField|
|UIButton|SignInButton、BackButton|
|UILabel|TipsLabel、HeartMapTitleLabel、HeartMapEndLabel、TerminalTitleLabel、RateLabel|
|UIVisualEffectView|	blurView|
|UISegmentedControl|	ModeSwitch|
|UITableView|	TerminalTableView|
|HeartState|	HeartMapView|

### 1.2.3 框架逻辑

