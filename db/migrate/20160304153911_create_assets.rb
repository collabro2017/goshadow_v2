class CreateAssets < ActiveRecord::Migration
  
  def up
    create_table :assets do |t|
      t.timestamps
      t.string :type, null: false
      t.attachment :attachment
      t.references :assetable, polymorphic: true, index: true
    end
  end

  def down
    drop_table :assets
  end
  
end
