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
      expect { template.render }.to raise_error(Mustache::ContextMiss)
    end

    describe '#render' do
      it "renders using the content of the template" do
        template.presents.should be_a_kind_of(Class)
        template.render.should == "I am a TEAPOT"
      end

      it "can render values from a hash" do
        template.presents = {:teapot => 'TEAPOT' }
        template.render.should == "I am a TEAPOT"
      end

      it "renders nothing when presenting a nil" do
        template.presents = nil
        template.render.should == nil
      end

      it "memoizes rendered text" do
        template.render.should   == "I am a TEAPOT"
        template.rendered.should == "I am a TEAPOT"

        template.presents = {:teapot => 'HORSERADISH'}

        template.render.should   == "I am a TEAPOT"
        template.rendered.should == "I am a TEAPOT"
      end

      it "can be reset when memoized" do
        template.render.should   == "I am a TEAPOT"
        template.presents = {:teapot => 'HORSERADISH'}

        template.render.should                 == "I am a TEAPOT"
        template.render(:force => true).should == "I am a HORSERADISH"
      end
    end

    describe '#present' do
      it "sets attribute 'presents' & renders all at once" do
        template.render.should   == "I am a TEAPOT"
        template.present(:teapot => 'TURNIP').should == "I am a TURNIP"
        template.presents.should == {:teapot => 'TURNIP'}
      end
    end

  end
end
