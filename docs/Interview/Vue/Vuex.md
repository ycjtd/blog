### 从 vuex 中获取的数据能直接更改吗

不能直接更改，需要浅拷贝对象之后更改，否则会报错

### vuex 中 actions 和 mutations 有什么区别

1. 改 `Vuex` 的 `store` 中的状态的唯一方法是提交 `mutation`，`mutation` 非常类似于事件：每个 `mutation` 都有一个字符串的类型 (`type`)和一个 回调函数 (`handler`) 。`Action` 类似于 `mutation`，不同在于：`Action`可以包含任意异步操作，但它不能修改状态， 需要提交`mutation`才能变更状态
2. 开发时，包含异步操作或者复杂业务组合时使用`action`；需要直接修改状态则提交`mutation`。但由于`dispatch`和`commit`是两个`API`，容易引起混淆，实践中也会采用统一使用`dispatch action`的方式。调用`dispatch`和`commit`两个`API`时几乎完全一样，但是定义两者时却不甚相同，`mutation`的回调函数接收参数是`state`对象。`action`则是与`Store`实例具有相同方法和属性的上下文`context`对象，因此一般会解构它为`{commit, dispatch, state}`，从而方便编码。另外`dispatch`会返回`Promise`实例便于处理内部异步结果
3. 实现上`commit(type)`方法相当于调用`options.mutations[type](state)`；`dispatch(type)`方法相当于调用`options.actions[type](store)`，这样就很容易理解两者使用上的不同了

### 怎么监听 vuex 数据的变化

- 可以通过`watch`选项或者`watch`方法监听状态
- 可以使用`vuex`提供的 API：`store.subscribe()`

2. `watch`选项方式，可以以字符串形式监听`$store.state.xx`；`subscribe`方式，可以调用`store.subscribe(cb)`,回调函数接收`mutation`对象和`state`对象，这样可以进一步判断`mutation.type`是否是期待的那个，从而进一步做后续处理。
3. `watch`方式简单好用，且能获取变化前后值，首选；`subscribe`方法会被所有`commit`行为触发，因此还需要判断`mutation.type`，用起来略繁琐，一般用于`vuex`插件中

### vuex 页面刷新数据丢失怎么解决

1. `vuex`只是在内存保存状态，刷新之后就会丢失，如果要持久化就要存起来
2. `localStorage`就很合适，提交`mutation`的时候同时存入`localStorage`，`store`中把值取出作为`state`的初始值即可。
3. 这里有两个问题，不是所有状态都需要持久化；如果需要保存的状态很多，编写的代码就不够优雅，每个提交的地方都要单独做保存处理。这里就可以利用`vuex`提供的`subscribe`方法做一个统一的处理。甚至可以封装一个`vuex`插件以便复用。
4. 类似的插件有`vuex-persist`、`vuex-persistedstate`，内部的实现就是通过订阅`mutation`变化做统一处理，通过插件的选项控制哪些需要持久化

### pinia 有什么优点

**1. pinia 是什么？**

> - 在`Vue3`中，可以使用传统的`Vuex`来实现状态管理，也可以使用最新的`pinia`来实现状态管理，我们来看看官网如何解释`pinia`的：`Pinia` 是 `Vue` 的存储库，它允许您跨组件/页面共享状态。
> - 实际上，`pinia`就是`Vuex`的升级版，官网也说过，为了尊重原作者，所以取名`pinia`，而没有取名`Vuex`，所以大家可以直接将`pinia`比作为`Vue3`的`Vuex`

**2. 为什么要使用 pinia？**

- `Vue2`和`Vue3`都支持，这让我们同时使用`Vue2`和`Vue3`的小伙伴都能很快上手。
- `pinia`中只有`state`、`getter`、`action`，抛弃了`Vuex`中的`Mutation`，`Vuex`中`mutation`一直都不太受小伙伴们的待见，`pinia`直接抛弃它了，这无疑减少了我们工作量。
- `pinia`中`action`支持同步和异步，`Vuex`不支持
- 良好的`Typescript`支持，毕竟我们`Vue3`都推荐使用`TS`来编写，这个时候使用`pinia`就非常合适了
- 无需再创建各个模块嵌套了，`Vuex`中如果数据过多，我们通常分模块来进行管理，稍显麻烦，而`pinia`中每个`store`都是独立的，互相不影响。
- 体积非常小，只有`1KB`左右。
- `pinia`支持插件来扩展自身功能。
- 支持服务端渲染

### 从零开始实现一个 vuex，说说思路

1. 官方说`vuex`是一个状态管理模式和库，并确保这些状态以可预期的方式变更。可见要实现一个`vuex`

- 要实现一个`Store`存储全局状态
- 要提供修改状态所需 API：`commit(type, payload), dispatch(type, payload)`

2. 实现`Store`时，可以定义`Store`类，构造函数接收选项`options`，设置属性`state`对外暴露状态，提供`commit`和`dispatch`修改属性`state`。这里需要设置`state`为响应式对象，同时将`Store`定义为一个`Vue`插件
3. `commit(type, payload)`方法中可以获取用户传入`mutations`并执行它，这样可以按用户提供的方法修改状态。 `dispatch(type, payload)`类似，但需要注意它可能是异步的，需要返回一个`Promise`给用户以处理异步结果
