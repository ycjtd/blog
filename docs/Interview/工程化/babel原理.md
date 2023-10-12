babel 主要用于将新版本的代码转换为向后兼容的 js 语法**(**​`Polyfill` 方式)，以便能够运行在各版本的浏览器或其他环境中

**基本原理**

首先将源码转成抽象语法树，然后对语法树进行处理生成新的语法树，最后将新语法树生成新的 JS 代码

1）通过`babylon`将 js 转化成 ast (抽象语法树)

2）通过`babel-traverse`是一个对 ast 进行遍历，使用 babel 插件转化成新的 ast

3）通过`babel-generator`将 ast 生成新的 js 代码
