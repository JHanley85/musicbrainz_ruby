class CreateMmbrains < ActiveRecord::Migration
  def change
    create_table :mmbrains do |t|
      t.string :name

      t.timestamps
    end
  end
end
