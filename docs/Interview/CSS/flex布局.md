采用 flex 布局的元素，称为 flex 容器，它的所有子元素自动成为容器成员，容器中默认存在两条轴，主轴和交叉轴，项目默认沿主轴排列

### 容器属性：

- flex-direction：决定主轴的方向，row-reverse：主轴为水平方向，起点在左端，column：主轴为垂直方向，起点在上沿，column-reverse：主轴为垂直方向，起点在下沿
- flex-wrap：如果主轴排列不下，通过这个属性判断是否换行，wrap：换行，在第一行下方，wrap-reverse：换行，在第一行上方
- flex-flow：flex-direction 和 flex-wrap 的缩写
- justify-content：定义在主轴上的对齐方式，flex-start：默认，左对齐，flex-end：右对齐，center：居中，space-between：两端对齐，项目之间的间隔相等，space-around：两个项目两侧间隔相等
- align-items：定义在交叉轴上的对齐方式，flex-start：交叉轴起点对齐，flex-end：交叉轴终点对齐，center：居中对齐，baseline：项目的第一行文字的基线对齐，stretch：默认值，如果项目未设置高度或者设置为 auto，占满整个容器的高度
- align-content：多根轴线的对齐方式，如果只有一根轴线，不起作用。flex-start：和交叉轴的起点对齐，flex-end：和交叉轴终点对齐，center：和交叉轴的中点对齐，space-between：和交叉轴两端对齐，轴线之间的间隔平均分布，space-around：每根轴线两侧的间隔都相等，stretch：默认值，轴线占满整个交叉轴

### 容器成员属性：

- order：项目排列顺序，数值越小越靠前，默认为 0
- flex-grow：如果不换行，容器宽度不够分的情况，弹性元素会根据这个来决定，项目的放大比例，默认为 0，即使存在剩余空间，也不放大，如果所有项目的 flex-grow 都为 1，等分剩余空间
- flex-shrink：定义项目缩小比例，默认为 1，如果空间不足，项目缩小，如果所有项目的 flex-shrink 都为 1，当空间不足时，等比例缩小
- flex-basis
