# WallpaperWeather
iOS小项目第一弹之壁纸天气
***
##前言 ：
***
**1. 整体项目回顾**

 距离上次发表文章也有大概两个月的时间了吧，这段时间一直在忙着公司的项目。没有时间review代码（可能是比较懒吧😅，以后一定改正），这个"壁纸天气"前前后后大概花了10天时间，设计、开发都是我（PS：不好看就将就着看，我只是一个有情怀的程序猿😜），都是下班了写写，代码比较简单，结构也不是很复杂。

**3. 做这个app的初衷**

前面做的高仿项目都是高仿app，数据都是本地数据，这次想玩玩网上的，刚开始只是看到百度ApiStore上有免费的天气接口，我就试着用了一下，感觉还不错，那就干脆写个天气app玩玩吧。~~我就想要一个简单的app，就显示天气就好，其余过多的动画效果不需要，整体的页面无非就是`UITableView`、`UICollectionView`和一些 `UILabel`、`UIButton`的组合，理清楚思路就很好做了，其实UI搭建本身就是一件简单的事情，难的在于业务和逻辑的处理上。~~

**3.为什么叫壁纸天气？**

为了弥补画面的突兀感，主要是大片大片的白，我也不懂如何配色，我都用一张图片当做背景，O(∩_∩)O~~，所以我就起名叫做"壁纸天气"了。

***
##项目的整体介绍：
***
###**1. 功能简介：**
####Tips:功能比较少，有以下几个：
#####①.  显示天气：首页显示添加过的城市的天气
#####②.  添加城市: 仅限与国内。
#####③.  管理已经添加的城市
` `
###**2. 功能展示：**

#####①. 天气展示主页面 :类似于首页

![首页展示.gif](http://upload-images.jianshu.io/upload_images/1299512-abf220551fb21483.gif?imageMogr2/auto-orient/strip)
######点击每一个城市，弹出天气详情View，会显示该城市的历史天气和预测天气，其中今日天气还有诸如感冒指数、穿衣指数等一些提示。

![天气详情.gif](http://upload-images.jianshu.io/upload_images/1299512-f994d293274ee756.gif?imageMogr2/auto-orient/strip)
#####②. 添加城市
输入城市中文名，然后展示搜索结果，选择要添加的城市即可。

![添加城市.gif](http://upload-images.jianshu.io/upload_images/1299512-60d3e8005c05d251.gif?imageMogr2/auto-orient/strip)

#####③. 管理已经添加的城市
点击X删除选择的城市，
![管理城市.gif](http://upload-images.jianshu.io/upload_images/1299512-af536d4faed69db2.gif?imageMogr2/auto-orient/strip)

#####③. 关于作者(PS:这一部分其实不算功能了吧😁)

![关于作者.gif](http://upload-images.jianshu.io/upload_images/1299512-9971c3e9aac4bbdf.gif?imageMogr2/auto-orient/strip)

` `
###**3. 项目的实现方法：**
#####①. 开发过程中，大多数采用xib，我从纯代码的海洋里爬出来，看到了xib的新大陆😄，xib使用还是很方便的，代码量也少了很多，可是我依然喜欢纯代码😂
#####②.  数据的来源、请求与处理：
-----1.数据来源于百度ApiStore中的两个免费的天气接口,返回的数据都是JSON字符串：
> 第一个：根据城市中文名称 查询城市ID

> 第二个： 根据城市ID查询近7天的天气
图片展示：

![A5873AE1-3A82-496D-AE04-A1FEC252BFFE.png](http://upload-images.jianshu.io/upload_images/1299512-c9730c120b233fe3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
-----2.数据请求：
使用`NSURLSession`对应两个接口 封装了两个请求，没有使用第三方库。
-----3.数据处理：
 ① 根据JSON字符串写了对应的模型，使用`MJExtension`解析JSON，并转成对应的`model`
 ②数据存储采用`NSUserDefaults`，对于项目的城市的存储操作封装了一个类`CityManager`，管理所有的存储、读取操作(比如 返回热门城市列表、返回当前已选择的城市)
Tips:由于`NSUserDefaults`不能存储自定义对象，所以需要先归档后存储

***
##项目感想：
***

` `好吧，还没有怎么写就到项目感想了，这个项目结构非常简单，东西也比较少，但是麻雀虽小、五脏俱全，本地存储、网络请求都有，主要是这个`方正喵呜`字体真的非常萌啊，基本上所有的文字都采用的这个字体。由于精力有限，对应各种天气的图片并不全，只有几个大分类，比如''小雨"、"中雨"、"大雨"我都用的一个图片˜😂

正儿八经的说，做完这个小app，最主要的一个感想就是 _"做很简单，做好就不容易了"_

好吧，第一弹就到这里了

####下一弹预告 ：

######       一个黑白相间的、考验手速的小游戏，

##Github下载地址：
***
[点击去我的Github转转★](https://github.com/jiachenmu/WallpaperWeather/)

***
工作事宜及问题交流请联系QQ：1691919529
***
