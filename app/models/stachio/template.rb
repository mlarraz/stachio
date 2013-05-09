module Stachio
  class Template < ActiveRecord::Base
    attr_accessible :content, :template_name
  end
end
