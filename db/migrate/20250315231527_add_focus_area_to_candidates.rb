class AddFocusAreaToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :focus_area, :string
  end
end
