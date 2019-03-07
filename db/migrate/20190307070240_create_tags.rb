class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :title
      t.integer :count
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
