class RenameCulutureColumnToCulture < ActiveRecord::Migration[6.0]
  def change
    rename_column :company_cultures, :culuture_id, :culture_id
  end
end
