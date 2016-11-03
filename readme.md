# 支付宝 9.x 版本首页效果

对于新版支付宝首页的产品功能这里就不说什么了，一大堆人吐槽，我们只想要一个好好的支付工具，阿里硬是要融入社交...

今天这里不是来评论支付宝功能的，而是作为一个iOS开发人员在使用的过程中发现，首页这滑动好“怪异”啊~~

![](http://odumpn7vt.bkt.clouddn.com/Screen%20Shot%202016-10-11%20at%20%20PM.png)

首先，右侧的滚动条的位置好怪！为什么在中间？只能说明一个问题，这个tableview是从这里开始的。

其次，既然tableview在中间开始，那上面那一片view是如何滚动的（从滚动条可以看出不是tableviewheader）？而且和tableview做到无缝衔接。

再次，滑动tableview上面那块view，直接响应滑动。


通过上面种种奇怪的现象，于是我决定针对这个效果些一个demo来玩玩。


![](http://odumpn7vt.bkt.clouddn.com/Kapture%202016-11-03%20at%2017.56.59.gif)

demo地址: [https://github.com/seedotlee/AlipayIndexDemo](https://github.com/seedotlee/AlipayIndexDemo)

因为是demo嘛，所以代码就尽量简单，处理就基本只放在一个class中，这样比较容易理解，大家就不要吐槽这一块了~~~

## 关键点

经过我反复实验，还是 UIScrollView + UITableView 的方式实现最靠谱，那问题来了，如何处理两个ScrollView的滑动冲突？

答案就是关掉一个滑动！当然就是关掉tableview的滑动，通过外层scrollview的offset来直接控制tableview的滑动，关键代码：

```

func scrollViewDidScroll(_ scrollView: UIScrollView) {

      let y = scrollView.contentOffset.y
      if y <= 0 {
          var newFrame = self.headerView.frame
          newFrame.origin.y = y
          self.headerView.frame = newFrame

          newFrame = self.mainTableView.frame
          newFrame.origin.y = y + topOffsetY
          self.mainTableView.frame = newFrame

          //偏移量给到tableview，tableview自己来滑动
          self.mainTableView.setScrollViewContentOffSet(point: CGPoint(x: 0, y: y))

          //功能区状态回归
          newFrame = self.functionHeaderView.frame
          newFrame.origin.y = 0
          self.functionHeaderView.frame = newFrame

      } else if y < functionHeaderViewHeight && y > 0{
          //处理功能区隐藏和视差
          var newFrame = self.functionHeaderView.frame
          newFrame.origin.y = y/2
          self.functionHeaderView.frame = newFrame

          //处理透明度
          let alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0

          functionHeaderView.alpha = alpha
          if alpha > 0.5 {
              let newAlpha =  alpha*2 - 1
              mainNavView.alpha = newAlpha
              coverNavView.alpha = 0
          } else {
              let newAlpha =  alpha*2
              mainNavView.alpha = 0
              coverNavView.alpha = 1 - newAlpha
          }

      }


  }

```

这里的关键就是当想上滑动的时候，实际就是滑动最外层的scrollview，然而想下滑动到顶的时候仅仅只讲offset传递给tableview让其继续滚动。

tableview嵌入方式借鉴了：

https://github.com/Zhanggaoyi92/Alipay-8.11-update-demo
