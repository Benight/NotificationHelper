# NotificationHelper
NSNotificationCenter的封装，使用方便，并且不用考虑释放的问题

# 示例
![gif](https://github.com/Benight/NotificationHelper/blob/master/notiGIF.gif)


# 使用方法

### 接收通知
    [self addObserverForName:@"name" block:^(NSNotification * _Nullable note) {'Do Something'}];
### 发送通知
    [self postNotificationName:@"name" object:@"object" userInfo:@"userInfo"];

# 优点
    两句话就可以
    不用考虑内存释放
