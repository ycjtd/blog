**this 的绑定方式**

1. 默认绑定，非严格模式下 this 指向全局对象，严格模式下函数内的 this 指向 undefined，但是不会改变全局中 this 的指向
2. 隐式绑定，当函数引用有上下文对象的时候，比如 `obj.foo()`的调用方式，foo 内的 this 指向 obj，就是说指向调用者
3. 显示绑定，通过 call、apply、bind 方法直接指定 this 的指向对象，比如`foo.call(obj)`
4. new 构造函数，this 指向新生成的对象
5. 箭头函数，this 指向的是定义这个箭头函数的时候，外层环境中的 this，**箭头函数在定义的时候就指定了，不能改变**

```js
"use strict";
var a = 10; // var定义的a变量挂载到window对象上
function foo() {
  console.log("this1", this); // undefined
  console.log(window.a); // 10
  console.log(this.a); //  报错，Uncaught TypeError: Cannot read properties of undefined (reading 'a')
}
console.log("this2", this); // window
foo();

// note:开启了严格模式之和，只是使函数内的this指向undefined，不影响全局下的this的指向
```

```js
let a = 10;
const b = 20;
function foo() {
  console.log(this.a); // undefined
  console.log(this.b); // undefined
}
foo();
console.log(window.a); // undefined

// 使用let 和 const 声明的变量不会被绑定到window上
```

```js
var a = 1;
function foo() {
  var a = 2;
  console.log(this); // window
  console.log(this.a); // 1
}
foo();

// 这里需要注意的时候，是window调用的foo函数，所以foo中的this指向window
```

```js
var obj2 = {
  a: 2,
  foo1: function () {
    console.log(this.a); // 2
  },
  foo2: function () {
    setTimeout(function () {
      console.log(this); // window
      console.log(this.a); // 3
    }, 0);
  },
};
var a = 3;

obj2.foo1();
obj2.foo2();

// 对于setTimeout中的函数，存在隐式绑定的丢失，也就是当讲函数作为参数传递的时候，会被隐式赋值，回调函数丢失this绑定，所以setTimeout中函数内的this指向window
```

```js
var obj = {
  name: "obj",
  foo1: () => {
    console.log(this.name); // window
  },
  foo2: function () {
    console.log(this.name); // obj
    return () => {
      console.log(this.name); // obj
    };
  },
};
var name = "window";
obj.foo1();
obj.foo2()();

// 对于obj.foo1()函数的调用，它的外层作用域是window，因为对象obj不属于作用域，所以会打印window
// 对于obj.foo2()第一个this.name指向的就是调用者obj，返回的匿名函数是一个箭头函数，this由外层函数决定，所以和foo函数的this一样，指向obj
```
