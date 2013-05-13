module Stachio
  module TemplatesHelper
    def readonly
      !!(Stachio::Engine.config.readonly)
    end
  end
end
