# frozen_string_literal: true

require "active_support/core_ext"

module BlueDoc::SML
  class Renderer
    include BlueDoc::SML::Utils

    attr_accessor :sml, :value, :config

    # For table, list for temp mark in block
    attr_accessor :in_block

    def initialize(sml, options)
      @sml = sml
      @config = Config.new
      @config.plantuml_service_host = options[:plantuml_service_host]
      @config.mathjax_service_host = options[:mathjax_service_host]
      @value = YAML.load(sml)
    end

    def to_html
      node_to_html(self.value)
    end

    def to_s
      to_html
    end

    def node_to_html(node, opts = {})
      opts[:renderer] = self

      rule = BlueDoc::SML::Rules::find_by_node(node)
      rule.to_html(node, opts)
    end

    def children_to_html(node)
      return node if node.is_a?(String)

      children = self.class.get_children(node)
      children.each_with_index.map do |child, idx|
        prev_node = idx > 0 ? children[idx - 1] : nil
        next_node = idx < children.length ? children[idx + 1] : nil

        node_to_html(child, prev: prev_node, next: next_node)
      end.join("")
    end

    def to_text
      node_to_text(self.value)
    end

    def node_to_text(node, opts = {})
      opts[:renderer] = self
      rule = BlueDoc::SML::Rules::find_by_node(node)
      rule.to_text(node, opts)&.strip
    end

    def children_to_text(node)
      return node if node.is_a?(String)
      children = self.class.get_children(node)
      children.each_with_index.map do |child, idx|
        text = node_to_text(child, {})
        text.blank? ? nil : text
      end.compact.join(" ")
    end
  end
end
