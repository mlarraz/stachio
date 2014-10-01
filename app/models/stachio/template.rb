module Stachio
  Mustache.raise_on_context_miss = true

  class Template < ActiveRecord::Base
    lookup_by :template_name

    validates_presence_of :template_name, :content

    attr_accessor :presents, :rendered

    def reset
      self.rendered = nil
    end

    def render(options={})
      options = options.with_indifferent_access
      reset if !!(options[:force] or options[:reset])
      self.rendered ||= Mustache.render(content, presents) unless presents.nil?
    end
    alias_method :assemble,  :render
    alias_method :composite, :render
    alias_method :compose,   :render

    def present(values=nil, options={})
      return render if values.nil?
      self.presents = values
      render options.merge(:force => true)
    end

    def describe(n=32)
      (description && description.size > n) ? description[0..n] + ' [...]' : description
    end
  end
end
