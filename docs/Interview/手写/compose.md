接收多个函数为参数，由右向左依次执行函数

```js
function compose(...fns) {
  // 首先需要判断参数是否为空
  if (fns.length === 0) {
    throw new Error("必须传入至少一个参数");
  }

  // 判断参数是否都为函数
  for (const fn of fns) {
    if (typeof fn !== "function") {
      throw new Error("传入的所有参数都必须为函数");
    }
  }

  return function (input) {
    return fns.reduceRight((result, fn) => fn(result), input);
  };
}
```
