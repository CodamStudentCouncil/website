class RenameCandidateDescriptionToMotivation < ActiveRecord::Migration[8.0]
  def change
    rename_column :candidates, :description, :motivation
  end
end
