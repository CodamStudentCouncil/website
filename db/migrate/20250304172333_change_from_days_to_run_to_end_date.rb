class ChangeFromDaysToRunToEndDate < ActiveRecord::Migration[8.0]
  def up
    add_column :elections, :end, :date

    Election.all.each do |e|
      e.update!(end: e.start + e.days_to_run)
    end

    change_column :elections, :end, :date, null: false

    remove_column :elections, :days_to_run
  end

  def down
    add_column :elections, :days_to_run, :integer, default: 7

    Election.all.each do |e|
      e.update!(days_to_run: (e.end - e.start).to_i)
    end

    change_column :elections, :days_to_run, :integer, null: false

    remove_column :elections, :end
  end
end
