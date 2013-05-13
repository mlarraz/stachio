module Stachio
  module ApplicationHelper
    def readonly
      !!(Stachio::Engine.config.readonly)
    end
  end
end
