class BirthdayReminderWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  attr_reader :user_id

  def perform(user_id)
    ::BirthdayReminder.call(user_id)
  end
end
