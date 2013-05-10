require 'stachio/proxy'

module Stachio
  class Template < ActiveRecord::Base
    lookup_by :template_name

    attr_accessible :template_name, :content
    validates_presence_of :template_name, :content

    attr_accessor :proxied

    def proxy
      @proxy ||= Stachio::Proxy.new(proxied) unless proxied.nil?
    end

    def compose
      proxy.template = content
      proxy.render
    end
  end
end
