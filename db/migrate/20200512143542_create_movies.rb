class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :director
      t.integer :duration_min
      t.datetime :release_year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
