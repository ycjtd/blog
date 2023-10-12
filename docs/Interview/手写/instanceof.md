```js
function myInstanceof(obj, constructor) {
  if (typeof obj !== "object" || obj === null) return false;

  let proto = Object.getPrototypeOf(obj);
  while (proto) {
    if (proto === constructor.prototype) return true;
    proto = Object.getPrototypeOf(proto);
  }
  return false;
}
```
