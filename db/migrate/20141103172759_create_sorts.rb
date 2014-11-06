class CreateSorts < ActiveRecord::Migration
  def change
    create_table :sorts do |t|
      t.string :name, default: 'unknown'
    end

    add_index :sorts, [:name]
  end
end
