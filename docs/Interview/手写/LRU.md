```js
// 缓存淘汰策略，移除最近最少被访问的数据项

class LRUCache {
  constructor(capacity) {
    this.map = new Map();
    this.capacity = capacity;
  }

  // 取值的时候，如果缓存中存在该键值对，先删除再重新插入，表示最近访问
  get(key) {
    if (this.map.has(key)) {
      const value = this.map.get(key);
      this.map.delete(key, value);
      this.map.set(key, value);
      return value;
    }
    // 如果缓存中不存在该键，返回 -1
    return -1;
  }

  put(key, value) {
    if (this.map.has(key)) {
      // 如果缓存中存在该键值对，删除旧的数据
      this.map.delete(key);
    }
    this.map.set(key, value);
    if (this.map.size > this.capacity) {
      // 如果缓存已满，删除最久未被访问的数据
      this.map.delete(this.map.keys().next().value);
    }
  }
}
```
