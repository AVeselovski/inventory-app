class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
