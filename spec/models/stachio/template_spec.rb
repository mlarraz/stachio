require 'rails_helper'

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
      expect(template.save!).to be_truthy
      expect(Template.count).to eql(1)
      expect(Template.first).to eq(template)
    end

    it "validates the presence of template_name" do
      template.template_name = ""
      expect(template).not_to be_valid
      template.template_name = "but i am a template!"
      expect(template).to be_valid
    end

    it "validates the presence of content" do
      template.content = ""
      expect(template).not_to be_valid
      template.content = "but i am a {{teapot}}!"
      expect(template).to be_valid
    end

    it "fetches templates from the database using the template name" do
      template.save!
      expect(template).to eq(Template['mrs.potts'])
    end

    it "reports an error when it can't compose the message" do
      template.content = "I am not a valid {{horseradish}}"
      expect { template.render }.to raise_error(Mustache::ContextMiss)
    end

    describe '#render' do
      it "renders using the content of the template" do
        expect(template.presents).to be_a_kind_of(Class)
        expect(template.render).to eq("I am a TEAPOT")
      end

      it "can render values from a hash" do
        template.presents = {:teapot => 'TEAPOT' }
        expect(template.render).to eq("I am a TEAPOT")
      end

      it "renders nothing when presenting a nil" do
        template.presents = nil
        expect(template.render).to eq(nil)
      end

      it "memoizes rendered text" do
        expect(template.render).to   eq("I am a TEAPOT")
        expect(template.rendered).to eq("I am a TEAPOT")

        template.presents = {:teapot => 'HORSERADISH'}

        expect(template.render).to   eq("I am a TEAPOT")
        expect(template.rendered).to eq("I am a TEAPOT")
      end

      it "can be reset when memoized" do
        expect(template.render).to   eq("I am a TEAPOT")
        template.presents = {:teapot => 'HORSERADISH'}

        expect(template.render).to                 eq("I am a TEAPOT")
        expect(template.render(:force => true)).to eq("I am a HORSERADISH")
      end
    end

    describe '#present' do
      it "sets attribute 'presents' & renders all at once" do
        expect(template.render).to   eq("I am a TEAPOT")
        expect(template.present(:teapot => 'TURNIP')).to eq("I am a TURNIP")
        expect(template.presents).to eq({:teapot => 'TURNIP'})
      end
    end

  end
end
