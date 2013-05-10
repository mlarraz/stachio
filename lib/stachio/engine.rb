module Stachio
  class Engine < ::Rails::Engine
    isolate_namespace Stachio

    require 'lookup_by'
    require "jquery-rails"

    require "mustache"
    require "stache"     ## use mustache/handlebars for views
    Stache.use :mustache

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
