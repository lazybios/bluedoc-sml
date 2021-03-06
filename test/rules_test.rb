# frozen_string_literal: true

require "test_helper"

class BlueDoc::SML::RulesTest < ActiveSupport::TestCase
  def render(sml, opts = {})
    BlueDoc::SML.parse(sml, opts).to_html
  end

  test "root" do
    sml = %(["root", ["body", ["p", "Hello world"]]])
    html = %(<body><p>Hello world</p></body>)
    assert_equal html, render(sml)
  end

  test "div, html, body" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, render(sml)
  end

  test "paragraph" do
    sml = %(["p", { align: "center", indent: 1 }, "Hello world"])
    html = %(<p style="text-align: center;">Hello world</p>)
    assert_equal html, render(sml)

    sml = %(["p", { align: "center", indent: { firstline: 1,  left: 2 } }, "Hello world"])
    html = %(<p style="text-align: center; text-indent: 32px; padding-left: 16px;">Hello world</p>)
    assert_equal html, render(sml)

    sml = %(["p", { align: "center", indent: { firstline: 0,  left: 0 } }, "Hello world"])
    html = %(<p style="text-align: center;">Hello world</p>)
    assert_equal html, render(sml)

    sml = <<~SML
    ["root",{},
      ["p",{"indent":{"firstline":0,"left":4}},["span",{"t":1},["span",{"t":0},"Paragraph wants indent"]]],
      ["p",{"indent":{"firstline":0,"left":0}},["span",{"t":1},["span",{"t":0},"No indent"]]],
    ]
    SML

    html = %(<p style="padding-left: 32px;">Paragraph wants indent</p><p>No indent</p>)
    assert_equal html, render(sml)
  end

  test "span and marks" do
    sml = %(["span", {}, "Foo"])
    assert_equal %(<span>Foo</span>), render(sml)

    # code
    sml = %(["span", { t: 0, cd: 1 }, "code"])
    assert_equal %(<code>code</code>), render(sml)
    sml = %(["span", { t: 0, cd: 1 }, ["p", "code"]])
    assert_equal %(<code>code</code>), render(sml)

    # bold
    sml = %(["span", { t: 0, b: 1 }, "bold"])
    assert_equal %(<strong>bold</strong>), render(sml)

    # italic
    sml = %(["span", { t: 0, i: 1 }, "italic"])
    assert_equal %(<i>italic</i>), render(sml)

    # strikethrough
    sml = %(["span", { t: 0, s: 1 }, "strikethrough"])
    assert_equal %(<del>strikethrough</del>), render(sml)

    # mark
    sml = %(["span", { t: 0, m: 1 }, "mark"])
    assert_equal %(<mark>mark</mark>), render(sml)

    # subscript
    sml = %(["span", { t: 0, sub: 1 }, "subscript"])
    assert_equal %(<sub>subscript</sub>), render(sml)

    # supscript
    sml = %(["span", { t: 0, sup: 1 }, "supscript"])
    assert_equal %(<sup>supscript</sup>), render(sml)
  end

  test "heading" do
    sml = %(["h1", {}, "Heading 1"])
    assert_equal %(<h1 id="heading-1"><a href="#heading-1" class="heading-anchor">#</a>Heading 1</h1>), render(sml)

    sml = %(["h2", {}, "确保 id 生成是固定的编号"])
    assert_equal %(<h2 id="583a03ad8"><a href="#583a03ad8" class="heading-anchor">#</a>确保 id 生成是固定的编号</h2>), render(sml)

    sml = %(["h3", {}, "This_? is"])
    assert_equal %(<h3 id="this-is"><a href="#this-is" class="heading-anchor">#</a>This_? is</h3>), render(sml)

    sml = %(["h4", {}, "Heading 4"])
    assert_equal %(<h4 id="heading-4"><a href="#heading-4" class="heading-anchor">#</a>Heading 4</h4>), render(sml)

    sml = %(["h5", {}, "Heading 5"])
    assert_equal %(<h5 id="heading-5"><a href="#heading-5" class="heading-anchor">#</a>Heading 5</h5>), render(sml)

    sml = %(["h6", {}, "Heading 6"])
    assert_equal %(<h6 id="heading-6"><a href="#heading-6" class="heading-anchor">#</a>Heading 6</h6>), render(sml)

    # Strip blank
    sml = %(["h6", {}, "   Heading 6   "])
    assert_equal %(<h6 id="heading-6"><a href="#heading-6" class="heading-anchor">#</a>Heading 6</h6>), render(sml)

    # title text is nil
    sml = %(["h2", {}])
    assert_equal %(<h2></h2>), render(sml)

    # title text is blank spaces
    sml = %(["h3", {}, "   "])
    assert_equal %(<h3></h3>), render(sml)
  end

  test "link" do
    sml = %(["link", { href: "https://bluedoc.io", title: "BlueDoc" }, "Hello world"])
    html = %(<a href="https://bluedoc.io" title="BlueDoc" target="_blank">Hello world</a>)
    assert_equal html, render(sml)

    sml = %(["link", { title: "BlueDoc" }, "Hello world"])
    assert_equal "Hello world", render(sml)
  end

  test "hr" do
    sml = %(["hr"])
    assert_equal "<hr>", render(sml)
  end

  test "image" do
    sml = %(["image", { name: "Foo.jpg", src: "/uploads/foo.jpg", width: 300, height: 200 }])
    html = %(<img src="/uploads/foo.jpg" alt="Foo.jpg" width="300" height="200">)
    assert_equal html, render(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", width: 300 }])
    html = %(<img src="/uploads/foo.jpg" width="300">)
    assert_equal html, render(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", height: 300 }])
    html = %(<img src="/uploads/foo.jpg" height="300">)
    assert_equal html, render(sml)

    # width, height = 0
    sml = %(["image", { src: "/uploads/foo.jpg", width: 0, height: 0 }])
    html = %(<img src="/uploads/foo.jpg">)
    assert_equal html, render(sml)

    # src is nil
    sml = %(["image", { name: "Foo.jpg", height: 300 }])
    assert_equal "Foo.jpg", render(sml)

    # src, name both nil
    sml = %(["image", { }])
    assert_equal "", render(sml)
  end

  test "file" do
    sml = %(["file", { name: "Foo-bar.pdf", src: "/uploads/foo.pdf", size: 612821 }])
    html = <<~HTML
    <a class="attachment-file" title="Foo-bar.pdf" target="_blank" href="/uploads/foo.pdf">
      <span class="icon-box"><i class="fas fa-file"></i></span>
      <span class="filename">Foo-bar.pdf</span>
      <span class="filesize">598 KB</span>
    </a>
    HTML
    assert_equal html, render(sml)

    # escape html
    sml = %(["file", { name: "<script>-bar.pdf", src: "/uploads/foo.pdf", size: "<script>" }])
    html = <<~HTML
    <a class="attachment-file" title="<script>-bar.pdf" target="_blank" href="/uploads/foo.pdf">
      <span class="icon-box"><i class="fas fa-file"></i></span>
      <span class="filename">&lt;script&gt;-bar.pdf</span>
      <span class="filesize">&lt;script&gt;</span>
    </a>
    HTML
    assert_equal html, render(sml)

    # src is nil, return name
    sml = %(["file", { name: "Foo bar.pdf" }])
    assert_equal "Foo bar.pdf", render(sml)

    # src, and name both empty
    sml = %(["file", {}])
    assert_equal "", render(sml)
  end

  test "blockquote" do
    sml = %(["blockquote", ["p", "Hello world"]])
    html = %(<blockquote><p>Hello world</p></blockquote>)
    assert_equal html, render(sml)
  end

  test "br" do
    sml = %(["br"])
    html = %(<br>)
    assert_equal html, render(sml)
  end

  test "codeblock" do
    code = <<~CODE
    class BlueDoc
      def version
        '0.1.0'
      end
    end
    CODE

    sml = %(["codeblock", { code: "#{code}", language: "ruby" }])

    html = <<~HTML
    <div class="highlight">
      <pre class="highlight ruby"><code><span class="k">class</span> <span class="nc">BlueDoc</span> <span class="k">def</span> <span class="nf">version</span> <span class="s1">'0.1.0'</span> <span class="k">end</span> <span class="k">end</span> </code></pre>
    </div>
    HTML
    assert_html_equal html, render(sml)

    # code is nil
    sml = %(["codeblock", { language: "rust" }])
    assert_equal %(<div class="highlight"><pre class="highlight rust"><code></code></pre></div>), render(sml)

    # language is nil
    sml = %(["codeblock", { code: "foo = bar" }])
    assert_equal %(<div class="highlight"><pre class="highlight plaintext"><code>foo = bar</code></pre></div>), render(sml)
  end

  test "math" do
    sml = %(["math", { code: "x^2 + y = z" }])
    html = %(<img class="tex-image" src="https://localhost:4010/svg?tex=x%5E2%20+%20y%20=%20z">)
    assert_html_equal html, render(sml, mathjax_service_host: "https://localhost:4010")

    # skip nil
    sml = %(["math", {}])
    assert_html_equal "", render(sml, mathjax_service_host: "https://localhost:4010")

    # strip
    sml = %(["math", { code: "  x^2 + y = z  "}])
    html = %(<img class="tex-image" src="https://localhost:4010/svg?tex=x%5E2%20+%20y%20=%20z">)
    assert_html_equal html, render(sml, mathjax_service_host: "https://localhost:4010")
  end

  test "plantuml" do
    code = <<~CODE
    @startuml
    Alice -> Bob: test
    @enduml
    CODE

    sml = %(["plantuml", { code: "#{code}" }])
    html = %(<img src="https://localhost:1020/svg/U9npA2v9B2efpSrHSCp9J4vLqBLJSCfFib8eIIqkKN18pKi1IW40vuuCU000" class="plantuml-image" />)
    out = render(sml, plantuml_service_host: "https://localhost:1020")
    assert_equal html, out

    sml = %(["plantuml", {}])
    assert_equal "", render(sml, plantuml_service_host: "https://localhost:1020")

    sml = %(["plantuml", { code: " Foo "}])
    assert_equal %(<img src="https://localhost:1020/svg/U9npoyy7008Y0IK0" class="plantuml-image" />), render(sml, plantuml_service_host: "https://localhost:1020")
  end

  test "video" do
    sml = %(["video", { src: "/uploads/foo.mov", type: "video/mov", width: 300, height: 200 }])
    html = <<~HTML
    <video controls preload="no" width="300">
      <source src="/uploads/foo.mov" type="video/mov">
    </video>
    HTML
    assert_html_equal html, render(sml)

    # auto fix widith
    sml = %(["video", { src: "/uploads/foo.mov", type: "video/mov", width: 0 }])
    html = <<~HTML
    <video controls preload="no" width="100%">
      <source src="/uploads/foo.mov" type="video/mov">
    </video>
    HTML
    assert_equal html, render(sml)

    sml = %(["video", { src: "/uploads/foo.mov" }])
    html = <<~HTML
    <video controls preload="no" width="100%">
      <source src="/uploads/foo.mov" type="">
    </video>
    HTML
    assert_equal html, render(sml)

    # src is nil, return empty
    sml = %(["video", { type: "video/mov", width: 300, height: 200 }])
    assert_equal "", render(sml)
  end

  test "list" do
    sml = <<~SML
    ["root",{},
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":0},["span",{"t":1},["span",{"t":0},"Bold text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":1},["span",{"t":1},["span",{"t":0},"Important text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"Italic text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":3,"indent":{"firstline":0,"left":12},"num":2},["span",{"t":1},["span",{"t":0},"Emphasized text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":4,"indent":{"firstline":0,"left":16},"num":3},["span",{"t":1},["span",{"t":0},"Marked text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":2},["span",{"t":1},["span",{"t":0},"Small text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":3},["span",{"t":1},["span",{"t":0},"Deleted text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":2},["span",{"t":1},["span",{"t":0},"Inserted text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"Subscript text"]]],
      ["list",{"nid":"28uu0ut4xdm","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":3},["span",{"t":1},["span",{"t":0},"Superscript text"]]],
      ["p",{},["span",{"t":1},["span",{"t":0},""]]]
    ]
    SML

    html = %(
    <ul data-level="1">
      <li>Bold text</li>
      <li>Important text
        <ul data-level="2">
          <li>Italic text
            <ul data-level="3">
              <li>Emphasized text
                <ul data-level="4">
                  <li>Marked text</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
        <ul data-level="2">
          <li>Small text</li>
          <li>Deleted text</li>
        </ul>
      </li>
    </ul>
    <ul data-level="1">
      <li>Inserted text
        <ul data-level="2">
          <li>Subscript text</li>
        </ul>
      </li>
    </ul>
    <ul data-level="1">
      <li>Superscript text</li>
    </ul>
    <p></p>
    )
    out = render(sml)
    # puts out
    assert_html_equal html, out
  end

  test "list with other tag or empty after n depth" do
    sml = <<~SML
    ["root",
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":1,"indent":{"firstline":0,"left":4},"num":0},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":2,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":3,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["list",{"nid":"rbsdl4hfcz9","type":"bulleted","pstyle":"paragraph","level":4,"indent":{"firstline":0,"left":8},"num":1},["span",{"t":1},["span",{"t":0},"hello"]]],
     ["p", {}, "Hello world"]
    ]
    SML

    html = <<~HTML
    <ul data-level="1">
      <li>hello
        <ul data-level="2">
          <li>hello
            <ul data-level="3">
              <li>hello
                <ul data-level="4">
                  <li>hello</li>
                </ul>
              </li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
    <p>Hello world</p>
    HTML

    out = render(sml)
    # puts format_html(out)
    assert_html_equal html, out
  end

  test "table" do
    sml = %(["root",{},["table",{"colsWidth":[60,60,60]},["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"版本"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"功能"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"说明"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{"jc":"left"},["span",{"t":1},["span",{"t":0},"v2.1.0"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"Hello world"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.7.2"]]]]],["tr",{},["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"v2.0.8"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"修复一处 crash"]]]],["tc",{"colSpan":1,"rowSpan":1},["p",{},["span",{"t":1},["span",{"t":0},"2018.5.21"]]]]]],["p",{},["span",{"t":1},["span",{"t":0},""]]]])
    html = %(<table><tr><td><p>版本</p></td><td><p>功能</p></td><td><p>说明</p></td></tr><tr><td><p>v2.1.0</p></td><td><p>Hello world</p></td><td><p>2018.7.2</p></td></tr><tr><td><p>v2.0.8</p></td><td><p>修复一处 crash</p></td><td><p>2018.5.21</p></td></tr></table><p></p>)
    out = render(sml)

    assert_equal html, out
  end

  test "td" do
    sml = %(["tc", { align: "right", indent: { firstline: 1 } }, "Hello world"])
    html = %(<td style="text-align: right; text-indent: 32px;">Hello world</td>)
    assert_equal html, render(sml)
  end

  test "mention" do
    sml = %(["mention", { username: "huacnlee", name: "Jason Lee" }, "@Jason Lee"])
    html = %(<a class="user-mention" href="/huacnlee" title="Jason Lee (huacnlee)">@<span class="mention-name">Jason Lee</span></a>)
    assert_equal html, render(sml)

    sml = %(["mention", { name: "Jason Lee" }, "@Jason Lee"])
    html = %(@Jason Lee)
    assert_equal html, render(sml)
  end
end
