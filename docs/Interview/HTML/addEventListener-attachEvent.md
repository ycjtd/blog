- 前者是标准浏览器中的用法，后者`IE8`以下
- `addEventListener`可有冒泡，可有捕获；`attachEvent`只有冒泡，没有捕获。
- 前者事件名不带`on`，后者带`on`
- 前者回调函数中的`this`指向当前元素，后者指向`window`
- 第三个参数涉及到冒泡和捕获，是`true`时为捕获，是`false`则为冒泡。
