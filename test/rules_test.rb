require 'test_helper'

class BookLab::SML::RulesTest < ActiveSupport::TestCase
  test "div, html, body" do
    sml = %(["html", { lang: "en" }, ["body", ["p", "Hello world"]]])
    html = %(<html><body><p>Hello world</p></body></html>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "link" do
    sml = %(["link", { href: "https://booklab.io", title: "BookLab" }, "Hello world"])
    html = %(<a href="https://booklab.io" title="BookLab">Hello world</a>)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["link", { title: "BookLab" }, "Hello world"])
    assert_equal "Hello world", BookLab::SML.parse(sml)
  end

  test "hr" do
    sml = %(["hr"])
    assert_equal "<hr>", BookLab::SML.parse(sml)
  end

  test "image" do
    sml = %(["image", { name: "Foo.jpg", src: "/uploads/foo.jpg", width: 300, height: 200 }])
    html = %(<img src="/uploads/foo.jpg" alt="Foo.jpg" width="300" height="200">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", width: 300 }])
    html = %(<img src="/uploads/foo.jpg" width="300">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { src: "/uploads/foo.jpg", height: 300 }])
    html = %(<img src="/uploads/foo.jpg" height="300">)
    assert_equal html, BookLab::SML.parse(sml)

    sml = %(["image", { name: "Foo.jpg", height: 300 }])
    assert_equal "Foo.jpg", BookLab::SML.parse(sml)
  end

  test "blockquote" do
    sml = %(["blockquote", ["p", "Hello world"]])
    html = %(<blockquote><p>Hello world</p></blockquote>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "br" do
    sml = %(["br"])
    html = %(<br>)
    assert_equal html, BookLab::SML.parse(sml)
  end

  test "codeblock" do
    code = <<~CODE
    class BookLab
      def version
        '0.1.0'
      end
    end
    CODE

    sml = %(["codeblock", { code: "#{code}", language: "ruby" }])

    html = <<~HTML
    <div class="highlight">
      <pre class="highlight ruby">
        <code><span class="k">class</span> <span class="nc">BookLab</span> <span class="k">def</span> <span class="nf">version</span> <span class="s1">'0.1.0'</span> <span class="k">end</span> <span class="k">end</span> </code>
      </pre>
    </div>
    HTML
    assert_html_equal html, BookLab::SML.parse(sml)
  end
end