class RenameStartAndEndDateColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :elections, :start, :start_date
    rename_column :elections, :end, :end_date
  end
end
