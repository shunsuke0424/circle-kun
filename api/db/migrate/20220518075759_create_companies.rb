class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null:false, index: {unique: true, length: 256}
      t.integer :number
      t.text :detail
      t.text :images_path
      t.text :hp_link
      t.text :twitter_link
      t.text :instagram_link
      t.string :company_category
      t.timestamps
    end
  end
end
