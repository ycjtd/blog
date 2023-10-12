setTimeout 模拟实现 setInterval

    ```js
    function mySetInterval(callback, delay) {
      function interval() {
        callback(); // 首先执行回调函数
        timer = setTimeout(interval, delay); // 设置下一次执行interval函数，达到模拟循环
      }

      // 第一次interval函数，在delay后执行interval
      let timer = setTimeout(interval, delay);

      return {
        clear: function () { // 返回清除定时器的方法
          clearTimeout(timer);
        },
      };
    }
    ```

setInterval 模拟实现 setTimeout

    ```js
    function mySetTimeout(callback, delay) {
      let timer = null;

      function timeout() {
        callback();  // 执行回调
        clearInterval(timer);// 清除定时器
      }

      timer = setInterval(timeout, delay);

      return {
        clear: function () {
          clearInterval(timer);
        },
      };
    }
    ```
