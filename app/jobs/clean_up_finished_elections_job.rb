class CleanUpFinishedElectionsJob < ApplicationJob
  include Sentry::Cron::MonitorCheckIns

  sentry_monitor_check_ins

  queue_as :cron

  def perform(*args)
    Election.where(finalized: false).where("end_date < ?", Time.zone.now.to_date)
    .each do |e|
      if e.to_be_finalized?
        logger
        e.clean_up_registrations!
        e.update!(finalized: true)
      end
    end
  end
end
