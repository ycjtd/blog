### loader 是什么

webpack 只能处理 js 格式的资源，任何非 js 文件都必须被对应的 loader 处理转换成 js 代码

### 手写一个 loader

```js
// 作用：将css内容，通过style标签插入到页面中
// source为要处理的css源文件
function loader(source) {
  let style = `
    let style = document.createElement('style');
    style.setAttribute("type", "text/css");
    style.innerHTML = ${source};
    document.head.appendChild(style)`;
  return style;
}
module.exports = loader;
```

### loader 的执行顺序

相同优先级的 loader 链，执行顺序为从右到左，从下到上

### 常见的 loader

- style-loader：把 css 注入到 JavaScript 中，通过 DOM 操作去加载 css
- css-loader：加载 css
- sass-loader：把 sass/scss 代码转换成 css
- url-loader：和 file-loader 类似，区别是用户可以设置一个阈值，大于阈值交给 file-loader 处理，小于阈值返回文件的 base64 编码
- vue-loader：加载 Vue.js 单文件组件
- raw-loader：加载文件原始内容（utf-8）
- file-loader：把文件输出到一个文件夹中，在代码中通过相对 URL 去引用输出的文件
- image-loader:加载并且压缩图片文件
- json-loader:加载 JSON 文件
- babel-loader：把 ES6 转换成 ES5
- ts-loader：将 typescript 转换成 JavaScript
