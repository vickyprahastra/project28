class User < ApplicationRecord

  after_update :refresh_worker
  after_create :create_reminder

  def full_name
    "#{first_name} #{last_name}"
  end

  def  next_reminder_time
    year = Date.today.year
    mmdd = birthday.strftime('%m%d')
    year += 1 if mmdd < Date.today.strftime('%m%d')
    mmdd = '0301' if mmdd == '0229' && !Date.parse("#{year}0101").leap?
    at_time = '0900' # Ping time!
    ActiveSupport::TimeZone[location].parse("#{year}#{mmdd}#{at_time}").localtime
  end

  def refresh_worker
    cancel_reminder
    create_reminder
  end

  private

  def create_reminder
    job_id = BirthdayReminderWorker.perform_at(next_reminder_time, id)
    self.update_columns(task_id: job_id)
  end

  def cancel_reminder
    # Initiate Sidekiq job records
    scheduled = Sidekiq::ScheduledSet.new
    # Delete old reminder task
    scheduled.find_job(task_id)&.delete
  end
end
