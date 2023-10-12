css 里的 visibility 属性有个 collapse 属性值，在不同浏览器下有什么区别

通常用于表格的行和列

当用于行上的时候：该行会被隐藏，并且不会占据任何空间，相邻的行自动合并

当用于列上的时候：该列会被隐藏，但任会占据空间，不会导致相邻元素合并

当一个元素的 visibility 属性被设置成 collapse 值后，对于一般的元素，它的表现跟 hidden 是一样的。

1. chrome 中，使用 collapse 值和使用 hidden 没有区别。
2. firefox，opera 和 IE，使用 collapse 值和使用 display：none 没有什么区别。
