class ChangeCompanyCuluturesToCompanyCultures < ActiveRecord::Migration[6.0]
  def change
    rename_table :company_culutures, :company_cultures
  end
end
