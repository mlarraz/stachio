module Stachio
  class ApplicationController < ActionController::Base
    def readonly
      !!(Stachio::Engine.config.readonly)
    end
  end
end
