unless ENV['COVERAGE'] == 'false'
  require 'simplecov-rcov'

  class SimpleCov::Formatter::MergedFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      SimpleCov::Formatter::RcovFormatter.new.format(result)
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

  SimpleCov.start('rails') do
    add_filter                "vendor/ruby/"
    add_filter                "spec/dummy"

    add_group "Models",       "app/models"
    add_group "Views",        "app/views"
    add_group "Controllers",  "app/controllers"
  end
end
