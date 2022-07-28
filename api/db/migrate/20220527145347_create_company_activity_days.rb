class CreateCompanyActivityDays < ActiveRecord::Migration[6.0]
  def change
    create_table :company_activity_days do |t|
      t.references :company, null: false, foreign_key: true
      t.string :activity_day, null: false
      t.timestamps
      
      t.index [:company_id, :activity_day], unique: true, name: :index_unique_company_activity_days
    end
  end
end
