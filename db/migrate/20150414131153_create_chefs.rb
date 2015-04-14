class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :chefname
      t.string :email
      t.timestamp
    end
  end
end
