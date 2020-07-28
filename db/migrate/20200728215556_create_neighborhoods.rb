class CreateNeighborhoods < ActiveRecord::Migration[6.0]
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
