### Proxy 与 Object.defineProperty 优劣对比

Object.defineProperty()存在的问题：

- 不能监听数组的变化：无法监控到数组下标的变化，导致通过数组下标添加元素，不能实时响应
- 必须遍历对象的每个属性：只能劫持对象的属性，从而需要对每个对象，每个属性进行遍历，如果属性值是对象，还需要深度遍历。

Proxy 优势：

- 针对对象：针对整个对象，而不是对象的某个属性，所以也就不需要对 keys 进行遍历
- 支持数组：Proxy 不需要对数组的方法进行重载，省去了众多 hack，减少代码量等于减少了维护成本

### ref 和 reactive 的区别

reactive 用于处理对象类型的数据响应式，底层采用 new Proxy（）

ref 通常用于处理单值的响应式问题，底层采用的是 Object.defineProperty()

### watch 和 watchEffect 的区别

- watch 需要手动指定要监视的数据和回调函数，具有更高的灵活性和定制性。watchEffect 会自动追踪函数内部使用的响应式数据，不需要显示指定
- watch 可以监视多个数据，可以在回调函数中处理多个函数的变化情况；watchEffect 只处理函数内部使用的响应式数据
- watch 可以通过配置选项来控制监听行为，比如 immediate，deep 等；watchEffect 相对更简单，没有额外的选项
- watch 的回调函数会接收新值和旧值作为参数，可以根据需要进行比较和处理；watchEffect 的回调函数只会被执行，不会传递参数

### Composition API 和 Options API 有什么不同

- 在逻辑组织和逻辑复用方面，`Composition API`是优于`Options API`
- 因为`Composition API`几乎是函数，会有更好的类型推断。
- `Composition API`对 `tree-shaking` 友好，代码也更容易压缩
- `Composition API`中见不到`this`的使用，减少了`this`指向不明的情况
- 如果是小型组件，可以继续使用`Options API`，也是十分友好的

### vue3 对 vue2 有什么优势

- 性能更好（编译优化、使用`proxy`等）
- 体积更小
- 更好的`TS`支持
- 更好的代码组织
- 更好的逻辑抽离
- 更多新功能

### vue3 和 vue2 生命周期有什么区别

**`Options API`**​**生命周期**

- `beforeDestroy`改为`beforeUnmount`
- `destroyed`改为`umounted`
- 其他沿用`vue2`生命周期

### Composition API 和 React Hooks 的区别

- `Composition API`的`setup`(相当于`created`、`beforeCreate`的合集)只会调用一次，而`React Hooks`函数在渲染过程中会被多次调用
- `Composition API`无需使用`useMemo`、`useCallback`避免子组件重复渲染，因为`setup`只会调用一次，在`setup`闭包中缓存了变量
- `Composition API`无需顾虑调用顺序，而`React Hooks`需要保证`hooks`的顺序一致（比如`不能放在循环、判断`里面）
- `Composition API`的`ref`、`reactive`比`useState`难理解

### vue3 新特性

1. `api`层面`Vue3`新特性主要包括：`Composition API`、`SFC Composition API`语法糖、`Teleport`传送门、`Fragments` 片段、`Emits`选项、自定义渲染器、`SFC CSS`变量、`Suspense`
2. 另外，`Vue3.0`在框架层面也有很多亮眼的改进：

- **更快**

  - 虚拟`DOM`重写，`diff`算法优化
  - 编译器优化：静态提升、`patchFlags（静态标记）`、事件监听缓存
  - 基于`Proxy`的响应式系统
  - `SSR`优化

- **更小**：更好的摇树优化 `tree shaking`、`Vue3`移除一些不常用的 `API`
- **更友好**：`vue3`在兼顾`vue2`的`options API`的同时还推出了`composition API`，大大增加了代码的逻辑组织和代码复用能力
- **更容易维护**：`TypeScript` + 模块化
- **更容易扩展**

  - 独立的响应化模块
  - 自定义渲染器

### Vue3 速度快的原因

Vue3.0 性能提升体现在哪些方面

- 代码层面性能优化主要体现在全新响应式`API`，基于`Proxy`实现，性能更好（获取到哪一层才触发响应式`get`，不是像`vue2`一次性递归监听数据）
- 编译层面做了更多编译优化处理，比如`静态标记 pachFlag`（`diff`算法增加了一个静态标记，只对比有标记的`dom`元素）、`事件增加缓存`、`静态提升`（对不参与更新的元素，会做静态提升，只会被创建一次，之后会在每次渲染时候被不停的复用）等，可以有效跳过大量`diff`过程；
- 打包时更好的支持`tree-shaking`，因此整体体积更小，加载更快
- `ssr`渲染以字符串方式渲染

### 为什么需要 ref、toRef、toRefs

为什么需要用 ref

- 返回值类型，会丢失响应式
- 如在`setup`、`computed`、合成函数，都有可能返回值类型
- `Vue`如不定义`ref`，用户将制造`ref`，反而更混乱

为何 ref 需要.value 属性

- `ref`是一个对象（不丢失响应式），`value`存储值
- 通过`.value`属性的`get`和`set`实现响应式
- 用于模板、`reactive`时，不需要`.value`，其他情况都要

为什么需要 toRef 和 toRefs

- **初衷**：不丢失响应式的情况下，把对象数据 `分解/扩散`
- **前端**：针对的是响应式对象（`reactive`封装的）非普通对象
- 注意：**不创造**响应式，而是**延续**响应式

### setup 如何获取组件实例

- 在`setup`和其他`composition API`中没有`this`
- 通过`getCurrentInstance`获取当前实例
- 若使用`options API`可以照常使用`this`
