class CreateSlumps < ActiveRecord::Migration
  def change
    create_table :slumps do |t|
      t.integer :year
      t.timestamps
      t.belongs_to :sort
      t.string :title
      t.text :plot            
      t.string :imdbid, null: false    
    end

    # Most searches are conducted on these two, so...
    add_index :slumps, [:title, :imdbid]
  end
end
