class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :rating
      t.date :date

      t.timestamps
    end
  end
end
