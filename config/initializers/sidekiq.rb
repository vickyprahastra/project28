Sidekiq.configure_server do |config|
  config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.configure_client do |config|
  config.redis = { ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.default_worker_options = { 'retry' => false }

schedule_file = 'config/schedule.yml'

# Sidekiq::Cron::Job.load_from_hash YAML.load(ERB.new(File.read(schedule_file)).result)
