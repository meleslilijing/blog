---
title: Vuex 笔记
date: 2017-10-25 12:36:21
tags:
---

# VUEX

## 概念
- store / module
- state / getters
- mutations / actions
	- payload: commit / dispatch时的参数
	- context: 一个store的新实例，vuex把react中的新state的immutable处理，在框架中就处理了
	- commit 
	- dispatch
- plugins
- strict
- 辅助函数： 用于`vuex`的`state`与`component`绑定
	- mapState / mapGetter： compose
	- mapAction / mapMutations: methods

**Redux**
>
`Dispatch` 执行一个 `Actions`, 通过 一个叫做 `Reducer`的映射表，计算出新的 `State`。 `Store`根据新的`State`去更新全局组件。

**Vuex**
>
通过辅助函数将store的属性与方法，绑定到component中。componet监听用户行为。commit / dispatch 一个行为给 mutation / action。 action 内部也是通过commit去执行 mutation。mutation相当于一个操作 state的列表。

	// example
	import Vue from 'vue';
	import Vuex from 'vuex';
	
	const store = new Vuex.Store({
		...
	})
	
	new Vue({
		el: '#app',
		store,
		...
	})

**store 与 component**

	// simpliest store
	const store = new Vuex.Store({
	  state: {
	    count: 0
	  },
	  mutations: {
	    increment (state) {
	      state.count++
	    }
	  }
	})

	1. 在 componet 中通过 this.$store 访问 store。
	2. store 触发行为
		this.$store.commit('mutation name', payload);
		this.$store.dispatch('dispatch name', payload);

**mutation 与 action**

	1. mutation 相当于 reducer。 mutation直接在内部改变 state。 reducer 返回一个新的state。
	2. mutation 只执行同步操作。 异步层面的操作放在 actions。 mutation是具体改变状态的行为，每次的 mutation 可能被 plugin 捕捉。
	3. actions 并不直接对 state进行操作。而是通过发起 mutation 执行操作。因此异步行为放在 actions。 可通过 Promise 或 async/await 去异步执行。
	4. mutation/actions 通过 mapMutations／mapActions 与具体的组件进行绑定。
	
	// mutationExap(state, payload) {}
	// actionExamp(context, payload) {}
	
	// example
	const store = new Vuex.Store({
		state: {
			count: 0,
			name: 'default name'
		},
		mutations: {
			exampleMutations1(state) {
				// do something
				state.count++
			},
			exampleMutations1(state, name) {
				
			}
		},
		actions：{
			exampleActions1(context) {
				context.commit('exampleMutations1');
			},
			exampleActions1(context) {
				// 'name' is payload
				context.commit('exampleMutations1', name); 
			}
		}
	});


## 基本规则
Vuex 并不限制你的代码结构。但是，它规定了一些需要遵守的规则：

1. 应用层级的状态应该集中到单个 store 对象中。
2. 提交 mutation 是更改状态的唯一方法，并且这个过程是同步的。
3. 异步逻辑都应该封装到 action 里面。

## state [type: Object]

	
	const	store = new Vuex.Store({
		state: {
			count: 1
		}
		mutations: ...
	})

## modules

	const moduleA = {
		state,
		mutations,
		actions, // 可无
		getters, // 可无
		modules  // 可无, 可嵌套
	}
	
	const moduleB = {
		state,
		mutations,
		actions,
		getters
		modules
	}
	
	const store = new Vuex.Store({
	  modules: {
	    a: moduleA,
	    b: moduleB
	  }
	})
	store.state.a; // -> moduleA 的状态
	store.state.a; // -> moduleB 的状态

## getter

	const store = new Vuex.Store({
		state: { ... },
		getter: {
			exampleGetter(state, getters) {
				return 
			}
		}
	})
	
	const module = {
		state: ...
		getter: {
			exampleGetter(state, getters, rootState)
		}
	}

## mutations [type: string]: Function

	// like Reducer
	const store = new Vuex.Store({
	  ...
	  mutations: {
	    increment (state, playload) {
	      // 变更状态
	      state.count++
	    }
	  }
	})
	
**Tips**

1. **mutation 必须是同步函数**  
2. devtools 不知道什么时候回调函数实际上被调用 —— 实质上任何在回调函数中进行的的状态的改变都是不可追踪的

## actions
*Action 函数接受一个与 store 实例具有相同方法和属性的 context 对象?*  

**支持异步：**

1. promise
2. async / await  
  
**示例代码：**

	function (context) {
	}
	
	context = { state, rootState, getters, commit, dispatch}

## 插件 plugins
https://vuex.vuejs.org/zh-cn/plugins.html

	store = new vuex.Store({
		...
		plugins: ['pluginA', 'pluginB']
		// plugins: process.env.NODE_ENV !== 'production' ? 
			[myPluginWithSnapshot] : []
	})

内置的 `Plugins` 插件:
- logger

## 模块动态注册 / 按需加载

	动态加载
	store.registerModule('myModule', {
	  // ...
	})
	store.state.myModule; // myModule的状态 
	
	store.unregisterModule(myModule); //卸载模块
	// 不能使用此方法( unregisterModule )卸载静态模块（在创建 store 时声明的模块）

需要 `vue` 插件  
例如，`vuex-router-sync` 插件可以集成 `vue-router` 与 `vuex`，管理动态模块的路由状态。

## 严格模式 / 生产环境 ／ 开发环境
详见：https://vuex.vuejs.org/zh-cn/strict.html  

**严格模式**

	const store = new Vuex.Store({
	  // ...
	  strict: true
	})

**环境**

	// 严格模式会对状态进行深度检测，影响性能
	// 因此，生产环境 禁用
	const store = new Vuex.Store({
	  // ...
	  strict: process.env.NODE_ENV !== 'production'
	})

## 测试
// TODO
https://vuex.vuejs.org/zh-cn/testing.html

## Api
https://vuex.vuejs.org/zh-cn/api.html