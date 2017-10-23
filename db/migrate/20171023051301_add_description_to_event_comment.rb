class AddDescriptionToEventComment < ActiveRecord::Migration[5.1]
  def change
    add_column :event_comments, :description, :string
  end
end
