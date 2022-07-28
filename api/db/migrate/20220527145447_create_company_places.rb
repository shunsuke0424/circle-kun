class CreateCompanyPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :company_places do |t|
      t.references :company, null: false, foreign_key: true
      t.string :place, null: false
      t.timestamps

      t.index [:company_id, :place], unique: true, name: :index_unique_company_places
    end
  end
end
