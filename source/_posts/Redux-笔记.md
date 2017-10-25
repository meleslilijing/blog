---
title: Redux 笔记
date: 2017-10-25 12:35:18
tags:
---

# Redux 笔记

TODO Redux 的执行过程

redux 本质是观察者模式

## 介绍
- Redux 和 React 之间没有必然关系。  
- redux 负责管理 整个 app state 的变化。  
- state 对应 model 层，react 负责 state 变化后对页面的重新渲染。  
- 引入 redux 后，container 只负责页面渲染和事件的调用。所有的事件具体的行为都在 actionCreater 与 reducer 中。 actions 相当于一个黑盒，具体的操作是在 reducer 中规定。  
- 本质上还是 Pub/Sub 模式

### 动机
JavaScript 需要管理比任何时候都要多的 state （状态），特别是在单页的情况下。
整个项目的state可以由各个component改变，导致state在开发过程中不受控制。
复杂性来源于： 变化和异步

直接改变state的行为：

1. 服务器响应
2. 缓存数据
3. 本地生成尚未持久化到服务器的数据
4. 用户触发的事件行为
5. 其他导致复杂性增加的行为：服务端渲染、路由跳转

Redux 试图让 state 的变化**可预测**

### 核心概念

### 三大原则
1. 单一数据源
2. 只读state
3. pure function 执行修改，最终只返回state

## 基础

## Action
Action 只是描述了有事情发生了。fire一个事件。

Tips: actionCreater func 与 action 不同。

	actionCreateDemo() {
		const action = {
			type: 'DEMO',
			data: 'actiondatas'
		}
		return action;
	}
	
	const dispatch = store.dispatch;
	
	dispatch(actionObject);
	dispatch(actionCreater(demodata));


## Reducer
指明如何更新state. type的值表明，action所fire的事件所对应的操作（store的变更）。

**永远不要在克隆 state 前修改它**

**Tips:**
1. 唯一的state。在数据传递和
2. state中也可能需要存储数据。*数据 value* 和 *UI value* 需要有明确划分。
3. 为了符合 **三大原则** pure render. 禁止在 reducer 中进行带有幅作用的操作。
>
	副作用：
		1.调用API请求 
		2.router跳转 
		3.调用非纯函数
		4. 直接改变原有的state，违反无副作用原则，因返回一个新的state

**拆分 reducer**

	// state 实际为 全局state.visibilityFilter
	function visibilityFilter(state, action) {
		switch (action.type) {
			case SET_VISIBILITY_FILTER:
				return action.filter;
		}
		return state
	}
	
	// state 实际为 全局state.todos
	function todoApp(state, action) {
		switch (action.type) {
			case TOGGLE_TODO:
				return state.map((todo, index) => {
	        if (index === action.index) {
	          return Object.assign({}, todo, {
	            completed: !todo.completed
	          })
	        }
	        return todo
	      })
		  default: 
				return state;		  
		}
	}
	
	// 写法1
	function todoApp(state = {}, action) {
	  return {
	    visibilityFilter: visibilityFilter(state.visibilityFilter, action),
	    todos: todos(state.todos, action)
	  }
	}
	
	// 写法2
	import { combineReducers } from 'redux';
	const todoApp = combineReducers({
	  visibilityFilter,
	  todos
	})
	
*写法1与写法2完全等价*

	const reducer = combineReducers({
		a: doSthA,
		b: doSthB
	})

等价于

	function reducer(state, action) {
		return {
			a: doSthA(state.a, action),
			b: doSthA(state.b, action)
		}
	}

## Store 

	store.getState()
	store.dispatch(action)
	store.subscribe()


## 数据流
单向数据流
几个概念之间的关系。理解了之前的内容，这里很好理解

- Store
- Action
- Reducer
- dispatch
- 页面组件

Store生成State

## 与React结合
容器组建（components）与展示组建(containers)
components就如同antd的组件。一切属性都是负责展示，对数据的操作都做为callback从props传入。

|  | Components | Containers |
|:--|:--|:--|
| 作用 | UI展示 | 数据处理，状态更新 |
| 直接使用 Redux | 否，只接受props和调用callback function | 是 |
| 数据来源 | props | Redux state |
| 数据修改 | 从 props 调用回调函数 | 触发Redux action |
| 调用方式 | 手动 | React-Redux connect生产 |

**Component**
传入什么就渲染什么。把代码从 Redux 迁移到别的架构，这些组件可以不做任何改动直接使用。它们并不依赖于 Redux。

**Container**

# 高级

## Middleware
redux的目的之一是让state的变化过程可预知和透明。所有的action都会经过 Middleware，因此可以在这里做统一的操作。如 异步action，log.  

总体类似 Server 端的数据流。Server端接收到的请求都会经过middleware处理。  

在react中也是类似，所有action都会经过middleware处理

## 异步 Action
redux-thunk

## 异步 Middleware
可以使用任意多异步的 middleware 去做你想做的事情，但是需要使用普通对象作为最后一个被 dispatch 的 action ，来将处理流程带回同步方式。

## Provier的子组件中，所有层级的组件都可以获得完整的state;

	import { Provider } from 'redux';
	import { connect } from 'react-redux';
	
	// example
	const initialState = {
		app:
	  app1: {
		  demo1: {
			  demo11: 'demo'
		  },
		  demo2: ...,
		  ...
	  }
		...
	}
	
	render(
		<Provider store={store} >
			<App>
				<Demo1>
					<Demo11></Demo11>
				</Demo1>
				<Demo2></Demo1>
				<Demo3></Demo1>
			</App>
		</Provider>
	)
	
	Provider中的各层级组件都可以通过 connect() 在 mapStateToProps,mapDispatchToProps中获得state。
	
	在App/Demo1/Demo2/Demo3/Demo11的connect中
	
	connect((state) => {
		console.log(state);
		
		// isObjectEqual(initialState, state) === true;
		
		return state;
	})(App/Demo1/Demo2/Demo3/Demo11);



## react/redux 单向数据流的描述
理解以下概念就能明白整个过程：

- store：state的容器
- state： 涉及全局的状态
- dispatch：对页面的一个操作称为一个dispatch
- action: 对state进行操作的请求
- actionCreater：根据参数生成action
- reducer: 对state进行改变的执行动作

特殊的API：

- redux/Provide： store注入
- redux/combinReducer： state合并
- react-redux/connect： state与component绑定

**过程：** 

TODO 执行过程


## immutable.js 的引入

理由：

- 项目规模增大会导致state的嵌套层级增大，避免频繁的深度拷贝
- 需要追踪某一时刻的页面状态


