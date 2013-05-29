class AddDescriptionToStachioTemplates < ActiveRecord::Migration
  def change
    add_column :stachio_templates, :description, :text
  end
end
