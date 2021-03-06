# frozen_string_literal: true

require "minitest/autorun"
require "active_support"
require "htmlbeautifier"
require "bluedoc-sml"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

class ActiveSupport::TestCase
  def read_file(fname)
    File.open(File.expand_path(File.join(__FILE__, "..", "fixtures", fname))).read
  end

  def assert_html_equal(excepted, html)
    assert_equal format_html(excepted), format_html(html)
  end

  def format_html(html)
    HtmlBeautifier.beautify(html, indent: "  ")
  end
end
