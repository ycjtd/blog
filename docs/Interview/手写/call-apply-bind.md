```js
// call
Function.prototype.myCall = function(context,...args){
	context = context || window
	context.fn = this
	const res = context.fn(...args)
	delete context.fn
	return res
}

// allpy
Function.prototype.myApply = function(context,args){
	context = context || window
	context.fn = this
	const res = context.fn(...args)
	delete context.fn
	return res
}

// bind
Function.prototype.myBind = function (context=window, ...args1) {
  // 首先需要进行判断，如果调用者不是函数，直接抛出异常
  let fn = this;
  let f = Symbol();
  const result = function (...args1) {
    if (this instanceof fn) {
      // result如果作为构造函数被调用，this指向的是new出来的对象
      // this instanceof fn，判断new出来的对象是否为fn的实例
      this[f] = fn;
      let res = this[f](...args, ...args1);
      delete this[f];
      return res;
    } else {
      // bind返回的函数作为普通函数被调用时
      context[f] = fn;
      let res = context[f](...args, ...args1);
      delete context[f];
      return res;
    }
  };
  // 如果绑定的是构造函数 那么需要继承构造函数原型属性和方法
  // 实现继承的方式: 使用Object.create
  result.prototype = Object.create(fn.prototype);
  return result;
};
```;
