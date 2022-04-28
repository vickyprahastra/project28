class BirthdayReminder
  attr_reader :user_id

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def self.call(user_id)
    new(user_id).call
  end

  def call
    send_happy_birthday
  end

  private

  def send_happy_birthday
    response = HTTParty.post(target_url, body: data)
    @user.update(last_birthday: Time.now) if response.success?
  end

  def target_url
    'https://hookb.in/LgzrqwJ6Bxs18Vqqgna7'
  end

  def data
    { message: "Hey, #{@user.full_name} it’s your birthday" }.to_json
  end
end
