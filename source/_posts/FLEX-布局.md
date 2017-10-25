---
title: FLEX 布局
date: 2017-10-25 12:31:33
tags:
---

# FLEX布局

可以参考阮一峰的教程，没什么好记录的。

目前在pc端还会有兼容性问题，还是离不开传统的布局方案（依赖 display 属性 + position属性 + float属性）。

## 基本概念

分为box和item. 
item的float、clear和vertical-align属性失效。

**常用属性：**

box:

- flex-direction: row | row-reverse | column | column-reverse; // 排列方向
- flex-wrap: nowrap | wrap | wrap-reverse; // 换行
- flex-flow: <flex-direction> || <flex-wrap>;
- justify-content: flex-start | flex-end | center | space-between | space-around; // 对齐方式
- align-items:  flex-start | flex-end | center | baseline | stretch; // 单行内纵向对齐
- align-content： flex-start | flex-end | center | space-between | space-around | stretch; // 纵向对齐

item:

- order: interger; // 排列顺序。数值越小，排列越靠前，默认为0。
- flex-grow: number; // 项目的放大比例，默认为0，即如果存在剩余空间，也不放大
- flex-shrink: number; // flex-shrink属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
- flex-basis: length | auto; 项目占据的主轴空间（main size）
- flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ] // flex-grow, flex-shrink 和 flex-basis的简写，默认值为0 1 auto。后两个属性可选。
- align-self: auto | flex-start | flex-end | center | baseline | stretch; // align-self属性允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。

**伪代码如下：**

	// html
	<box>
		<item1></item1>
		<item2></item2>
		<item3></item3>
		...
	</box>
	<inline-box>
		<item1></item1>
		<item2></item2>
		<item3></item3>
		...		
	</inline-box>
	
	// css
	.box {
		display: flex;
		flex-flow： row nowrap;
		justify-content: space-between;
		align-items: center;
	}
	
	.inline-box {
		display: inline-flex;
		...
	}
	
	.item1 {
		flex-grow: 1;
	}
	
	.item2 {
		flex-grow: 2;
	}
	
	.item3 {
		flex-grow: 1;
		align-self: flex-end;
	}
	

	flex-wrap
	justify-content