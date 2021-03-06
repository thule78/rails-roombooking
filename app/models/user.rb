class User < ApplicationRecord
  require 'twilio-ruby'
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]


  has_one_attached :image

  has_many :rooms
  has_many :reservations, dependent: :destroy

  has_many :guest_reviews, class_name: "GuestReview", foreign_key: 'guest_id'
  has_many :host_reviews, class_name: "HostReview", foreign_key: 'host_id'

  validates :name, presence: true, length: {maximum: 50}

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
        user.uid = auth.uid
        user.provider = auth.provider
      end
    end

    def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save
  end

  def send_pin
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    from = '+12563630643' # Your Twilio number
    to = self.phone_number # Your mobile phone number

    @client.messages.create(
    from: from,
    to: to,
    body: "Your pin is #{self.pin}"
    )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if self.pin == entered_pin
  end
end
