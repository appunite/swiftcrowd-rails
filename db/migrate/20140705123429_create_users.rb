class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name
      t.datetime :birthdate
      t.string :uuid
      t.text :image

      t.timestamps
    end
  end
end
