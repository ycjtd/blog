```js
// 传入参数为 url 请求地址
const getJSON = function (url) {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    // false 代表请求是同步的还是异步的，false表示同步
    xhr.open("GET", url, false);
    // 设置请求头，对于get请求不是必须的
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onreadystatechange = function () {
      if (xhr.readyState !== 4) return;
      if (xhr.status === 200 || xhr.status === 304) {
        resolve(xhr.responseText);
      } else {
        reject(new Error(xhr.responseText));
      }
    };
    xhr.send();
  });
};
```
