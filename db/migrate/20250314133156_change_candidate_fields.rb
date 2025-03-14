class ChangeCandidateFields < ActiveRecord::Migration[8.0]
  def change
    rename_column :candidates, :focus_area, :tagline
  end
end
