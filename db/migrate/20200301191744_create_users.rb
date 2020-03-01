class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :time1
      t.string :time2

      t.timestamps
    end
  end
end
