class CleanUpOldElectionsJob < ApplicationJob
  include Sentry::Cron::MonitorCheckIns

  sentry_monitor_check_ins

  queue_as :cron

  def perform(*args)
    Election.where("end_date < ?", Time.zone.now.to_date - 1.year).each do |e|
      e.destroy!
    end
  end
end
