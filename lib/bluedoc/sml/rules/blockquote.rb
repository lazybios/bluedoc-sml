# frozen_string_literal: true

module BlueDoc::SML::Rules
  class Blockquote < Base
    def self.match?(node)
      tag_name(node) == "blockquote"
    end

    def self.to_html(node, opts = {})
      renderer = opts[:renderer]
      attrs = attributes(node)

      children = renderer.children_to_html(node)

      %(<blockquote>#{children}</blockquote>)
    end
  end
end
