### vue 路由传参

- 使用 query 方法传入的参数使用`this.$route.query`接收
- 使用 params 方法传入的参数使用`this.$route.params`接收

### route 和 router 的区别

- route：当前 router 跳转对象，里面可以获取 name、path、query、params 等
- router：是 vue-router 的实例，想要导航到不同 URL，使用 router.push 方法

### 怎么定义动态路由，怎么获取传过来的参数

在 router 目录下的 index.js 文件中，对 path 属性加上 /:id，使用 router 对象的 params.if 获取动态参数

### vue 里面 router-link 在电脑上有用，安卓上没反应怎么解决

在安卓上有问题是 babel 的问题，安装 babel polypill 插件解决

### hash 和 history 路由模式实现原理

**`hash`**模式

早期的前端路由的实现就是基于 `location.hash` 来实现的。其实现原理很简单，`location.hash` 的值就是 `URL`中 `#` 后面的内容。比如下面这个网站，它的 `location.hash` 的值为 `'#search'`

```text
https://interview.poetries.top#search
```

hash 路由模式的实现主要是基于下面几个特性

- `URL` 中 `hash` 值只是客户端的一种状态，也就是说当向服务器端发出请求时，`hash` 部分不会被发送；
- `hash` 值的改变，都会在浏览器的访问历史中增加一个记录。因此我们能通过浏览器的回退、前进按钮控制 `hash` 的切换；
- 可以通过 `a` 标签，并设置 `href` 属性，当用户点击这个标签后，`URL` 的 `hash` 值会发生改变；或者使用 `JavaScript` 来对 `loaction.hash` 进行赋值，改变 `URL` 的 `hash` 值；
- 我们可以使用 `hashchange` 事件来监听 `hash` 值的变化，从而对页面进行跳转（渲染）

```js
window.addEventListener("hashchange", funcRef, false);
```

每一次改变 `hash`（`window.location.hash`），都会在浏览器的访问历史中增加一个记录利用 `hash` 的以上特点，就可以来实现前端路由“更新视图但不重新请求页面”的功能了

特点：兼容性好但是不美观

**2. ​**​**`history`**模式

`history`采用`HTML5`的新特性；且提供了两个新方法： `pushState()`， `replaceState()`可以对浏览器历史记录栈进行修改，以及`popState`事件的监听到状态变更

```js
window.history.pushState(null, null, path);
window.history.replaceState(null, null, path);

        @程序员poetry: 代码已经复制到剪贴板

```

这两个方法有个共同的特点：当调用他们修改浏览器历史记录栈后，虽然当前 `URL` 改变了，但浏览器不会刷新页面，这就为单页应用前端路由“更新视图但不重新请求页面”提供了基础。

history 路由模式的实现主要基于存在下面几个特性：

- `pushState` 和 `repalceState` 两个 `API` 来操作实现 `URL` 的变化 ；
- 我们可以使用 `popstate` 事件来监听 `url` 的变化，从而对页面进行跳转（渲染）；
- `history.pushState()` 或 `history.replaceState()` 不会触发 `popstate` 事件，这时我们需要手动触发页面跳转（渲染）。

特点：虽然美观，但是刷新会出现 `404` 需要后端进行配置

### router-view 和 router-link 是怎么起作用的

1. `vue-router`中两个重要组件`router-link`和`router-view`，分别起到路由导航作用和组件内容渲染作用
2. 使用中`router-link`默认生成一个`a`标签，设置`to`属性定义跳转`path`。实际上也可以通过`custom`和插槽自定义最终的展现形式。`router-view`是要显示组件的占位组件，可以嵌套，对应路由配置的嵌套关系，配合`name`可以显示具名组件，起到更强的布局作用。
3. `router-link`组件内部根据`custom`属性判断如何渲染最终生成节点，内部提供导航方法`navigate`，用户点击之后实际调用的是该方法，此方法最终会修改响应式的路由变量，然后重新去`routes`匹配出数组结果，`router-view`则根据其所处深度`deep`在匹配数组结果中找到对应的路由并获取组件，最终将其渲染出来。

### 了解 history 有哪些方法吗

`history` 这个对象在`html5`的时候新加入两个`api` `history.pushState()` 和 `history.repalceState()` 这两个`API`可以在不进行刷新的情况下，操作浏览器的历史纪录。唯一不同的是，前者是新增一个历史记录，后者是直接替换当前的历史记录。

- `window.history.back()` 后退
- `window.history.forward()`前进
- `window.history.go(1)` 前进或者后退几步

从触发事件的监听上来说：

- `pushState()`和`replaceState()`不能被`popstate`事件所监听
- 而后面三者可以，且用户点击浏览器前进后退键时也可以

### 怎么监听 pushState 和 replaceState 的变化

利用自定义事件`new Event()`创建这两个事件，并全局监听

### vue-router 如何保护路由

- `vue-router`中保护路由的方法叫做路由守卫，主要用来通过跳转或取消的方式守卫导航。
- 路由守卫有三个级别：`全局`、`路由独享`、`组件级`。影响范围由大到小，例如全局的`router.beforeEach()`，可以注册一个全局前置守卫，每次路由导航都会经过这个守卫，因此在其内部可以加入控制逻辑决定用户是否可以导航到目标路由；在路由注册的时候可以加入单路由独享的守卫，例如`beforeEnter`，守卫只在进入路由时触发，因此只会影响这个路由，控制更精确；我们还可以为路由组件添加守卫配置，例如`beforeRouteEnter`，会在渲染该组件的对应路由被验证前调用，控制的范围更精确了。
- 用户的任何导航行为都会走`navigate`方法，内部有个`guards`队列按顺序执行用户注册的守卫钩子函数，如果没有通过验证逻辑则会取消原有的导航。

### 怎么实现路由懒加载

1. 当打包构建应用时，JavaScript 包会变得非常大，影响页面加载。利用路由懒加载我们能把不同路由对应的组件分割成不同的代码块，然后当路由被访问的时候才加载对应组件，这样会更加高效，是一种优化手段
2. 一般来说，对所有的**路由都使用动态导入**是个好主意
3. 给`component`选项配置一个返回 `Promise` 组件的函数就可以定义懒加载路由。例如：`{ path: '/users/:id', component: () => import('./views/UserDetails') }`
4. 结合注释 `() => import(/* webpackChunkName: "group-user" */ './UserDetails.vue')` 可以做`webpack`代码分块

### 怎么从零开始实现一个 vue 路由

一个`SPA`应用的路由需要解决的问题是**页面跳转内容改变同时不刷新**，同时路由还需要以插件形式存在，所以：

1. 首先我会定义一个`createRouter`函数，返回路由器实例，实例内部做几件事

- 保存用户传入的配置项
- 监听`hash`或者`popstate`事件
- 回调里根据`path`匹配对应路由

2. 将`router`定义成一个`Vue`插件，即实现`install`方法，内部做两件事

- 实现两个全局组件：`router-link`和`router-view`，分别实现页面跳转和内容显示
- 定义两个全局变量：`$route`和`$router`，组件内可以访问当前路由和路由器实例
