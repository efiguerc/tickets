class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.references :customer, index: true, foreign_key: { to_table: :users }
      t.string :category
      t.string :title
      t.text :description
      t.integer :status
      t.integer :priority
      t.references :agent, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
