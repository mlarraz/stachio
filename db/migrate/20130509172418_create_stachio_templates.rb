class CreateStachioTemplates < ActiveRecord::Migration
  def change
    create_table :stachio_templates do |t|
      t.string :template_name
      t.text :content

      t.timestamps
    end
  end
end
