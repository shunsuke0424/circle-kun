class ChangeCuluturesToCultures < ActiveRecord::Migration[6.0]
  def change
    rename_table :culutures, :cultures
  end
end
