module Stachio
  class Engine < ::Rails::Engine
    isolate_namespace Stachio

    require 'stache'
    Stache.use :mustache ## Use mustache templates for views

  end
end
