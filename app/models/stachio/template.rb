module Stachio
  Mustache.raise_on_context_miss = true

  class Template < ActiveRecord::Base
    lookup_by :template_name

    attr_accessible :template_name, :content
    validates_presence_of :template_name, :content

    attr_accessor :presents

    def compose
      Mustache.render(content, presents) unless presents.nil?
    end
    alias_method :composite, :compose
    alias_method :render,    :compose
  end
end
