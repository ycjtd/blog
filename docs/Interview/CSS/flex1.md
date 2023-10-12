- `flex` 实际上是 `flex-grow：1`、`flex-shrink：1` 和 `flex-basis：0%` 三个属性的缩写。
- `flex-grow`：定义项目的的放大比例；

  - 默认为`0`，如果存在剩余空间，元素也不会放大，设置为 1，代表会放大，等分剩余空间
  - `flex-grow`为`n`的项目，占据的空间（放大的比例）是`flex-grow`为`1`的`n`倍

- `flex-shrink`：定义项目的缩小比例；

  - 默认为`1`，即 如果空间不足，该元素将缩小；
  - 所有项目的`flex-shrink`为`1`：当空间不足时，缩小的比例相同；
  - `flex-shrink`为`0`：空间不足时，该项目不会缩小；
  - `flex-shrink`为`n`的项目，空间不足时缩小的比例是`flex-shrink`为`1`的`n`倍。

- `flex-basis`： 定义在分配多余空间之前，项目占据的主轴空间（`main size`），浏览器根据此属性计算主轴是否有多余空间

  - 默认值为`auto`，即 项目原本大小，设置为 0%之后，因为有 flex-grow 和 flex-shrink 的设置会自动放大或缩小。
