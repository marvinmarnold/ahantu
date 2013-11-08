class WelcomeEmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(member_profile_id)
    member_profile = MemberProfile.find(member_profile_id)
    "#{member_profile.role}_mailer".camelize.constantize.welcome_email(member_profile).deliver
  end
end