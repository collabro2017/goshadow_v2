class CreateReports < ActiveRecord::Migration
  
  def up
    create_table :reports do |t|
      t.timestamps
      t.integer :experience_id, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.json :data, default: {}
    end
  end

  def down
    drop_table :reports
  end

end
