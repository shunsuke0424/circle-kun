class CreateKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :keywords do |t|
      t.string :content, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
