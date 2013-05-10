require 'spec_helper'

module Stachio
  class MockProxyObject
    def teapot
      "TEAPOT"
    end
  end

  describe Template do
    let(:template) do
      attrs = { :template_name => "my silly teapot",
                :content => "I am a {{teapot}}",
              }
      template = Template.new(attrs)
      template.proxied = MockProxyObject.new
      template
    end

    it "stores templates in the database" do
      template.save!.should be_true
      Template.count.should eql(1)
      Template.first.should == template
    end

    it "validates the presence of template_name" do
      template.template_name = ""
      template.should_not be_valid
      template.template_name = "but i am a template!"
      template.should be_valid
    end

    it "validates the presence of content" do
      template.content = ""
      template.should_not be_valid
      template.content = "but i am a {{teapot}}!"
      template.should be_valid
    end

    it "fetches templates from the database using the template name" do
      template.save!
      template.should == Template['my silly teapot']
    end

    it "composes messages using the content of the template" do
      template.compose.should == "I am a TEAPOT"
    end

    it "reports an error when it can't compose the message" do
      template.content = "I am not a valid {{horseradish}}"
      expect { template.compose }.to raise_error(Mustache::ContextMiss)
    end
  end
end
