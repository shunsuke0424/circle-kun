class CreateArts < ActiveRecord::Migration[6.0]
  def change
    create_table :arts do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
