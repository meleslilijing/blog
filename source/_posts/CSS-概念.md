---
title: CSS 概念
date: 2017-10-25 12:28:43
tags:
---

# CSS 概念

只涉及布局的概念。  
CSS属性**不正交**。即，一个CSS属性，可能对元素会有意想不到的改变。
各浏览器厂商在实现上有差异，因此CSS属性在实际情况中需要一定经验。

### 元素类型：

- 块级元素（block level element）
- 内联元素（inline element 有的人也叫它行内元素）

### block & inline的区别

1. 块级元素会独占一行（即无法与其他元素显示在同一行内，除非你显式修改元素的 display 属性），而内联元素则都会在一行内显示。
2. 内联元素无 width & height 属性
3. 块级元素的 width 默认为 100%，而内联元素则是根据其自身的内容或子元素来决定其宽度。

### inline-block

`display: inline-block;`
`inline-block` 在我看来就是让元素对外呈内联元素，可以和其他元素共处与一行内；对内则让元素呈块级元素，可改变其宽高。

### 流

关键属性: `position` & `float`, 元素的**流**。

- 普通流
- 浮动流
- 相对定位：没有脱离普通流
- 绝对定位：脱离普通流, 无视`float`
- fixed流：相对屏幕定位
- BFS：block formatting context。DOM tree的任意一个节点就算一个BFS。BFS内的布局不受外界影响。定位和清除浮动的样式规则只适用于处于同一块格式化上下文内的元素。

HTML 代码是顺序执行的，一份无任何 CSS 样式的 HTML 代码最终呈现出的页面是根据元素出现的顺序和类型排列的。块级元素就从上到下排列，遇到内联元素则从左到右排列。

## 盒模型

每个元素均遵守盒模型(box-model)。

box-del: 可以显而易见的看出盒模型由 4 部分组成。从内到外分别是：

`content -> padding -> border -> margin`
按理来说一个元素的宽度（高度以此类推）应该这样计算：

`box-sizing`属性可以改变盒模型。

	.example {
		box-sizing: border-box | content-box; 
	}

默认为 `content-box`， `border-box` 把 `padding` 值算在`width`, `height` 内。早期的IE浏览器也是这个模型。

## position

可能影响到 **流**。

**Tips：**
- relative： 元素依然在**普通流**中，位置是正常位置。可通过`left/right/top/bottom`移动位置，不会影响其他元素的位置，在定位中还是在原来的位置。
- absolute ／ fixed 的时候：把该元素往 Z 轴方向移了一层，元素脱离了普通流，所以不再占据原来那层的空间，还会覆盖下层的元素。

## float

float 元素浮动，在没有inline-block会给block添加float属性，代替inline-block

Tips：

- 只有左右浮动，没有上下浮动。
- 元素设置 float 之后，它会脱离普通流（和 position: absolute; 一样），不再占据原来那层的空间，还会覆盖下一层的元素。
- 浮动不会对该元素的上一个兄弟元素有任何影响。
- 浮动之后，该元素的下一个兄弟元素会紧贴到该元素之前没有设置 float 的元素之后（很好理解，因为该元素脱离普通流了，或者说不在这一层了，所以它的下一个元素当然要补上它的位置）。
- 如果该元素的下一个兄弟元素中有内联元素（通常是文字），则会围绕该元素显示，形成类似「文字围绕图片」的效果。（可参考CSS float浮动的深入研究、详解及拓展(一)中的讲解）。这个我还是实践了一下的：
- 下一个兄弟元素如果也设置了同一方向的 float，则会紧随该元素之后显示。
该元素将变为块级元素，相当于给该元素设置了 display: block;（和position: absolute; 一样）。

## 特殊的transform

对属性进行变形。也涉及到布局。使用**百分比属性**时，机遇目标元素的宽和高。

### margin
**负值 margin：**
`margin-left` & `margin-right`, 依赖**流**的特性可将元素负向移动。

**外边距合并：**
堆叠/贴合的margin，外边距合并。

外边距（margins）不会在绝对定位的元素上合并

### 百分比单位
目标元素的定位就依赖于父元素的宽（对于左右的偏移量）和高（对于上下的偏移量）。