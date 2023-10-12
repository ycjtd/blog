怎么修改 chrome 记住密码后自动填充表单的黄色背景

### 产生原因

由于 Chrome 默认会给自动填充的`input`表单加上 `input:-webkit-autofill` 私有属性造成的

### 解决方案

1. 在`form`标签上直接关闭了表单的自动填充：`autocomplete="off"`
2. `input:-webkit-autofill { background-color: transparent; }`

