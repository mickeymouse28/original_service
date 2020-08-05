class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :placename
      t.string :date
      t.string :content
      t.string :image
      t.integer :rate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
