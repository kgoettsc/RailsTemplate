class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    email = auth.info.email
    user = User.find_by(email: email)

    raise "Not Authorized" unless user.present?

    user.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
