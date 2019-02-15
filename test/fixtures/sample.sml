["root",{},["blockquote",{},["p",{},["span",{"t":1},["span",{"t":0,"cl":"rgb(106, 115, 125)","hl":"rgb(255, 255, 255)"},"Active Record "],["span",{"t":0,"cl":"rgb(106, 115, 125)","hl":"rgb(255, 255, 255)","b":1,"u":1,"i":1,"s":1},"负责"],["span",{"t":0,"cl":"rgb(106, 115, 125)","hl":"rgb(255, 255, 255)"},"创建和使用需要持久存入数据库中的数据。"]],["link",{"href":"https://rubyonrails.org"},["span",{"t":1},["span",{"t":0,"cl":"rgb(106, 115, 125)","hl":"rgb(255, 255, 255)"},"Active Record"]]],["span",{"t":1},["span",{"t":0,"cl":"rgb(106, 115, 125)","hl":"rgb(255, 255, 255)"}," 实现了 Active Record 模式，是一种对象关系映射系统。"]]],["p",{},["span",{"t":1},["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},"😄 还知道如何从数据库中读出数据"]]]],["h2",{"jc":"start"},["span",{"t":1},["span",{"t":0},"Active Record 模式"]]],["p",{"jc":"start"},["span",{"t":1},["span",{"t":0},""]],["image",{"src":"/uploads/L4hM6bDkRfKine7bRiLEVsaz","width":600,"height":348},["span",{"t":1},["span",{"t":0},""]]],["span",{"t":1},["span",{"t":0},""]]],["p",{},["span",{"t":1},["span",{"t":0},"对象关系映射（"],["span",{"t":0,"cd":1},"ORM"],["span",{"t":0},"）是一种技术手段，把应用中的对象和关系型数据库中的数据表连接起来。使用 "],["span",{"t":0,"cd":1},"ORM"],["span",{"t":0},"，应用中对象的属性和对象之间的关系可以通过一种简单的方法从数据库中获取，无需直接编写 SQL 语句，也不过度依赖特定的数据库种类。"]]],["list",{"nid":"2fcmfff4z5o","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":0},["span",{"t":1},["span",{"t":0},"表示模型和其中的数据；"]]],["list",{"nid":"2fcmfff4z5o","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":1},["span",{"t":1},["span",{"t":0},"表示模型之间的关系；"]]],["list",{"nid":"2fcmfff4z5o","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":2},["span",{"t":1},["span",{"t":0},"通过相关联的模型表示继承层次结构；"]]],["list",{"nid":"2fcmfff4z5o","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":3},["span",{"t":1},["span",{"t":0},"持久存入数据库之前，验证模型；"]]],["list",{"nid":"2fcmfff4z5o","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":4},["span",{"t":1},["span",{"t":0},"以面向对象的方式处理数据库操作。"]]],["h2",{"size":2,"_root":{"entries":[["num",4],["indent",{"firstline":0,"left":4}]]},"__altered":false,"indent":{"firstline":0,"left":0}},["span",{"t":1},["span",{"t":0},"有序列表"]]],["list",{"nid":"6b6q103l30p","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"ordered"},["span",{"t":1},["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},"查找模型和数据库表之间的映射关系"]]],["list",{"nid":"6b6q103l30p","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"ordered"},["span",{"t":1},["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},"模型类名为 "],["span",{"t":0,"cd":1,"cl":"rgb(34, 34, 34)","hl":"rgba(27, 31, 35, 0.0470588)"},"Book"],["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},"，数据表就是 "],["span",{"t":0,"cd":1,"cl":"rgb(34, 34, 34)","hl":"rgba(27, 31, 35, 0.0470588)"},"books"]]],["list",{"nid":"6b6q103l30p","level":1,"pstyle":"paragraph","indent":{"firstline":0,"left":4},"type":"ordered"},["span",{"t":1},["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},"类名转换成复数，然后查找对应的数据表"]]],["p",{"size":1,"_root":{"entries":[["indent",{"firstline":0,"left":4}]]},"__altered":false,"indent":{"firstline":0,"left":0}},["span",{"t":1},["span",{"t":0,"cl":"rgb(34, 34, 34)","hl":"rgb(255, 255, 255)"},""]]],["h3",{"size":1,"_root":{"entries":[["indent",{"firstline":0,"left":4}]]},"__altered":false,"indent":{"firstline":0,"left":0}},["span",{"t":1},["span",{"t":0},"代码演示"]]],["p",{"size":1,"_root":{"entries":[["indent",{"firstline":0,"left":4}]]},"__altered":false,"indent":{"firstline":0,"left":0}},["span",{"t":1},["span",{"t":0},"下面是一段 Ruby 代码演示"]]],["codeblock",{"code":"class BlueDoc\nend","language":"ruby"},["span",{"t":1},["span",{"t":0},""]]],["h2",{},["span",{"t":1},["span",{"t":0},"表格"]]],["table",{"colsWidth":[60,60]},["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"模型/类"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"表/模式"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"Article"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"articles"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"LineItem"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"line_items"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"Deer"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"deers"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"Mouse"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"mice"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"Person"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0,"cd":1,"hl":"rgba(27, 31, 35, 0.0470588)"},"people"]]]]]],["h2",{},["span",{"t":1},["span",{"t":0},"附件、PlantUML、TeX"]]],["plantuml",{"code":"@startuml\nHello -> World\n@enduml"},["span",{"t":1},["span",{"t":0},""]]],["p",{"code":"@startuml\nHello -> World\n@enduml"},["span",{"t":1},["span",{"t":0},""]],["math",{"code":"x^2 * y = z"},["span",{"t":1},["span",{"t":0},""]]],["span",{"t":1},["span",{"t":0},""]]],["file",{"name":"保险报销凭证-2.pdf","size":116574,"src":"/uploads/a6giKas5AvoJxkp12XXH68Cc"},["span",{"t":1},["span",{"t":0},""]]],["hr",["span",{"t":1},["span",{"t":0},""]]],["p",{},["span",{"t":1},["span",{"t":0},"这是末尾的内容"]]]]