---
title: Functional Programming 笔记
date: 2017-10-25 12:33:23
tags:
---

# Functional Programming 笔记

TODO

原书地址：[JS 函数式编程指南](https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/)

**Function Programming概念：**

- 一种编程范式。通常用于`计算密集`大于`IO密集`。
- FP以Function作为函数内的基本单位。OO是以Object作为基本单位。
- 整体就是以数据流的方式分别计算各个Function。最后通过`树形积累`，形成最终的结果。

## 一等公民函数

1. Function作为值处理：一等公民。
2. 无谓的间接层代码欠套

>
	// bad
	httpGet('/post/2', function(json){
	  return renderPost(json);
	});
	// good
	httpGet('/post/2', renderPost);
减少无谓的代码量。避免在内部function变更的同时，外部间接层的function进行变更。

3. 避免this的使用：this 就像一块脏尿布，我尽可能地避免使用它，因为在函数式编程中根本用不到它。然而，在使用其他的类库时，你却不得不向这个疯狂的世界低头。（ 低头的方式就是`bind`，控制类库和传递的Function ）	。

## 纯函数

1. 避免副作用
2. 相同的输入，得到相同的结果：纯函数就是数学上的函数，而且是函数式编程的全部

函数是一个界限。无副作用（函数不内的操作不影响外部的值）。
同样的输入，一定会有同样的输出。输出的值，不受function外部影响。

副作用：

- this
- 更改文件系统
- 往数据库插入记录
- 发送一个 http 请求
- 可变数据
- 打印/log
- 获取用户输入
- DOM 查询
- 访问系统状态

总之，所有的操作都在function的界限内

## Curry

## Compose


## 参考书目：

1. < JS函数式编程指南 > https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/ch1.html#一个简单例子

2. < SICP > 计算机的构造与解释
3. < JavaScript函数式编程 >
