module Stachio
  def self.readonly
    return Stachio::Engine.config.readonly if defined?(Stachio::Engine.config.readonly)
    (defined?(Rails) && Rails.env.production?) ? true : false
  end
end
