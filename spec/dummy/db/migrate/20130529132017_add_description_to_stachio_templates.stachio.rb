# This migration comes from stachio (originally 20130529130543)
class AddDescriptionToStachioTemplates < ActiveRecord::Migration
  def change
    add_column :stachio_templates, :description, :text
  end
end
