### 区别

HTTP 是超文本传输协议，明文传输，存在安全风险的问题，HTTPS 是为了解决 HTTP 不安全的缺陷，在 TCP 和 HTTP 网络层之间加入了 SSL/TSL 安全协议，使得报文能够密文传输

HTTP 连接建立相对简单，TCP 三次握手之后就可以进行 HTTP 的报文传输，HTTPS 在 TCP 三次握手之后还需要进行 SSL/TSL 的握手过程，才可以进行密文传输

HTTP 默认端口 80；HTTPS 默认端口 443

HTTPS 需要向 CA 申请数字证书，保证服务器的身份是可信的

### HTTPS 解决了哪些问题

HTTP 存在的问题：窃听风险：（通信链路上可以获取通信内容，用户信息容易泄露），篡改风险：（强制植入垃圾广告），冒充风险

HTTPS 在 HTTP 和 TCP 之间加入了 SSL/TSL 协议，将信息加密，使得交易信息不能被获取，通过校验机制，使得不能篡改通信内容，通过数字证书保证服务器的合法性

### 混合加密

通过混合加密的方法保证信息的机密性，采用对称加密和非对称加密的方式在通信建立前采用非对称加密的方式交换会话密钥，在通信过程中使用对称加密的方式进行加密明文数据

### HTTPS 握手过程

- 第一步，客户端给出协议版本号、一个客户端生成的随机数（Client random），以及客户端支持的加密方法
- 第二步，服务端确认双方使用的加密方法，并给出数字证书、以及一个服务器生成的随机数
- 第三步，客户端确认数字证书有效，然后生成一个新的随机数（Premaster secret），并使用数字证书中的公钥，加密这个随机数，发给服务端
- 第四步，服务端使用自己的私钥，获取客户端发来的随机数（即 Premaster secret）。
- 第五步，客户端和服务端根据约定的加密方法，使用前面的三个随机数，生成"对话密钥"（session key），用来加密接下来的整个对话过程

### 对称加密和非对称加密

- 对称加密： 对称加密指的就是加密和解密使用同一个秘钥，所以叫做对称加密。对称加密只有一个秘钥。
- 非对称加密: 加密和解密使用不同的秘钥，一把作为公开的公钥，另一把作为私钥。公钥加密的信息，只有私钥才能解密。

> 通过上面的握手过程可知，https 在证书验证阶段，使用非对称加密来传输共享秘钥，之后的传输中都使用对称加密方式。原因是，非对称加密的加解密效率是非常低的，而 http 场景中通常端与端之间的交互量很大，对非对称加密的效率是无法忍受的。另外， HTTPS 场景中只有服务端保存了私钥，一对公私钥只能实现单向加解密过程。因此 HTTPS 中的内容传输采用对称加密

**对称密钥加密和非对称密钥加密它们有什么区别**

- 对称密钥加密是最简单的一种加密方式，它的加解密用的都是相同的密钥，这样带来的好处就是加解密效率很快，但是并不安全，如果有人拿到了这把密钥那谁都可以进行解密了。
- 而非对称密钥会有两把密钥，一把是私钥，只有自己才有；一把是公钥，可以发布给任何人。并且加密的内容只有相匹配的密钥才能解。这样带来的一个好处就是能保证传输的内容是安全的，因为例如如果是公钥加密的数据，就算是第三方截取了这个数据但是没有对应的私钥也破解不了。不过它也有缺点，一是公钥因为是公开的，谁都可以过去，如果内容是通过私钥加密的话，那拥有对应公钥的黑客就可以用这个公钥来进行解密得到里面的信息；二来公钥里并没有包含服务器的信息，也就是并不能确保服务器身份的合法性；并且非对称加密的时候要消耗一定的时间，减低了数据的传输效率。

**混合加密机制的好处是什么**

- 对称密钥加密和非对称密钥加密都有它们各种的优缺点，而混合加密机制就是将两者结合利用它们各自的优点来进行加密传输。
- 比如既然对称密钥的优点是加解密效率快，那么在客户端与服务端确定了连接之后就可以用它来进行加密传输。不过前提是得解决双方都能安全的拿到这把对称密钥。这时候就可以里用非对称密钥加密来传输这把对称密钥，因为我们知道非对称密钥加密的优点就是能保证传输的内容是安全的。
- 所以它的好处是即保证了对称密钥能在双方之间安全的传输，又能使用对称加密方式进行通信，这比单纯的使用非对称加密通信快了很多。以此来解决了 HTTP 中内容可能被窃听的问题。

**混合加密的缺点**

> 混合加密主要是为了解决`HTTP`中内容可能被窃听的问题。但是它并不能保证数据的完整性，也就是说在传输的时候数据是有可能被第三方篡改的，比如完全替换掉，所以说它并不能校验数据的完整性。如果需要做到这一点就需要使用到数字签名。

### 怎么实现 token 加密

- 需要一个 secret（随机数）
- 后端利用 secret 和加密算法(如：HMAC-SHA256)对 payload(如账号密码) 生成一个字符串(token)，返回前端
- 前端每次 request 在 header 中带上 token
- 后端用同样的算法解密
