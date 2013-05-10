module Stachio
  class Proxy < Mustache
    self.raise_on_context_miss = true
    attr_accessor :proxied

    def initialize(proxied)
      self.proxied = proxied
    end

    def respond_to?(method, include_privates=false)
      return true if proxied.respond_to? method
      super
    end

    def method_missing(method, *args, &block)
      super unless proxied.respond_to?(method)
      proxied.send method, *args, &block
    end
  end
end
