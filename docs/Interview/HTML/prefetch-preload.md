**相同点**

都是告知浏览器提前加载文件(图片、视频、`js`、`css`等)，但执行上是有区别的。

**区别**

- `prefetch`预取：prefetch 是一个资源提示属性，用于告诉浏览器在页面加载完成后，异步地预取指定资源。这意味着浏览器会在**空闲**时加载这些资源，以备将来可能需要用到。prefetch 适用于当前页面未使用但可能在后续页面或用户操作中可能会用到的资源
- `preload`预加载 : `preload`是一个资源提示属性，用于告诉浏览器在页面加载时立即开始加载指定的资源。与`prefetch`不同，`preload`会在页面加载时立即下载资源，而不是在后台异步加载。`preload`适用于当前页面需要用到的重要资源，以优化关键资源的加载时间。