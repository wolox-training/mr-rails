require 'sidekiq-scheduler'

class ExpirationWorker
  include Sidekiq::Worker

  def perform
    Rent.find_by(end_date: Time.zone.today) do |rent|
      UserMailer.expiration_email(rent)
    end
  end
end
