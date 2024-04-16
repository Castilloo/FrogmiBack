class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :feature, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
