**题目：**

删除链表的倒数第 N 个结点 https://leetcode.cn/problems/remove-nth-node-from-end-of-list/

**description:**

给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。

**解题思路：**

```js
var removeNthFromEnd = function (head, n) {
  // 创建一个dummy节点，连接到链表的头部
  let dummy = new ListNode(0, head);
  // 获取链表的长度
  let len = getLen(head, n);
  // 计算要删除的节点再正向遍历中的位置
  let targetN = len - n;
  // cur指向dummy节点，用于遍历链表
  let cur = dummy;

  // 遍历到要删除的节点的前一个节点
  for (let i = 0; i < targetN; i++) {
    cur = cur.next;
  }
  // 删除要删除的节点
  cur.next = cur.next.next;

  // 返回要删除的节点
  return dummy.next;
};

// 获取链表长度
function getLen(head, n) {
  let len = 0;
  while (head) {
    len++;
    head = head.next;
  }
  return len;
}
```
