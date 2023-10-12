1. 创建一个对象，该对象的原型指向构造函数的原型
2. 调用该构造函数，构造函数的 this 指向新生成的对象
3. 判断构造函数是否有返回值，如果有返回值且返回值是一个对象或方法，就返回这个值，否则返回新生成的对象

```js
function myNew(constructor, ...args) {
  // 1.创建一个新对象，关联到构造函数的原型
  const obj = Object.create(constructor.prototype);

  // 2.调用构造函数，将新对象作为上下文
  const result = constructor.apply(obj, args);

  // 3.如果构造函数显示返回了一个对象，返回该对象
  if (typeof result === "object" && result !== null) {
    return result;
  }

  // 否则返回新对象
  return obj;
}
```
