### 基本实现

**Promise 特点**

- 当使用 promise 的时候，会传入一个执行器，这个执行器会立即执行
- executor 给了两个函数可以来描述当前 promise 的状态。Promise 中有三个状态，成功态、失败态、等待态 默认为等待态
- 如果调用 resolve,会走成功态,如果调用 reject 或者发生异常,会走失败态
- 每个 promise 实例都有一个 then 方法
- promise 一旦状态更改后就不能再次更改了

**Promise 怎么使用?**

根据使用来实现

```js
let Promise = require("./Promise/1.promise");
let promise = new Promise((resolve, reject) => {
  console.log("promise");
  resolve("成功");
  reject("失败");
});

promise.then(
  // then是异步的
  (res) => {
    console.log("success", res);
  },
  (err) => {
    console.log("err", err);
  }
);

console.log("ok");
```

根据使用方式可以得到
