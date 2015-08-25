# YPNBadgeView
自定义数字红点或小红点，类似iOS系统消息数字、微信、QQ提示等。


使用：

```
//设置对齐方式
self.badgeView.badgeAlignment = YPNBadgeAlignmentRight|YPNBadgeAlignmentTop;
//设置badgeView类型，包括小红点和数字两种类型
self.badgeView.badgeType = YPNBadgeTypePoint;
//设置文本
self.badgeView.badgeText = @"99";
```