class Owner < ApplicationRecord
  has_many :businesses

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_confirmation_of :password

  after_create :welcome_email

  def name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end

  private

  def welcome_email
    # Deliver the mail to the owner
    # ------------------------------
    # See https://stackoverflow.com/questions/8709984/how-to-catch-error-exception-in-actionmailer
    begin
      OwnerMailer.with(owner: self).welcome_email.deliver_now
    rescue Exception => e
      puts "ERREUR : Il y a eu un problème dans l'envoi du mail, merci de nous contacter"
    end
  end
end
