require 'spec_helper'

module Stachio
  describe Template do
    let(:presents) do
      Class.new { def self.teapot; 'TEAPOT'; end }
    end

    let(:template) do
      tmpl = Template.new :template_name => "mrs.potts",
                          :content => "I am a {{teapot}}"
      tmpl.presents = presents
      tmpl
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
      template.should == Template['mrs.potts']
    end

    it "reports an error when it can't compose the message" do
      template.content = "I am not a valid {{horseradish}}"
      expect { template.compose }.to raise_error(Mustache::ContextMiss)
    end

    describe 'presenting an object' do
      it "composes messages using the content of the template" do
        template.presents.should be_a_kind_of(Class)
        template.compose.should == "I am a TEAPOT"
      end
    end

    describe 'presenting a hash' do
      let(:presents)  {{ :teapot => 'TEAPOT' }}
      it "composes messages using the content of the template" do
        template.presents.should be_a_kind_of(Hash)
        template.compose.should == "I am a TEAPOT"
      end
    end

    describe 'presenting a nil' do
      let(:presents)  { nil }
      it "composes messages using the content of the template" do
        template.presents.should be_nil
        template.compose.should == nil
      end
    end
  end
end
