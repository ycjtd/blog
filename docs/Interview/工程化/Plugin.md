扩展 webpack 功能

### 工作原理

webpack 通过内部的事件流机制保证了插件的有序性，底层是利用发布订阅模式，webpack 在运行过程中会广播事件，插件只需要监听它所关系的事件，在特定的时间对资源做处理

### 编写一个插件

```js
// 自定义一个名为MyPlugin插件，该插件在打包完成后，在控制台输出"打包已完成"
class MyPlugin {
  // 原型上需要定义apply 的方法
  apply(compiler) {
    // 通过compiler获取webpack内部的钩子
    compiler.hooks.done.tap("My Plugin", (compilation, cb) => {
      console.log("打包已完成");
      // 分为同步和异步的钩子，异步钩子必须执行对应的回调
      cb();
    });
  }
}
module.exports = MyPlugin;
```
