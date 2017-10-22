class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :organizer_id
      t.integer :participant_id
      t.string :name
      t.string :location
      t.string :description
      t.string :date
      t.string :time
      t.string :category

      t.timestamps
    end
  end
end
