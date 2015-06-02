class User < ActiveRecord::Base
  has_secure_password

  # before the user gets added for the first time
  # do this —> set token
  before_create :set_token
  # want the token to reset after a day or so
  # this will force the change
  # everytime they hit your website
  # it will check to see if their token
  # has been updated in the past 24 hours
  # if not, it will update it
  after_find :fix_up_token
  # make sure you can't save someone
  # who has a duplicate email
  validates :email, uniqueness: true

  def authenticate_with_new_token(password)
    authenticate_without_new_token(password) && new_token
  end

  alias_method_chain :authenticate, :new_token

  private

  # validaate that the token doesn't already exist
  def set_token
    self.token = SecureRandom.hex(16)
  end

  # unconditionally create and set a new token
  def new_token
    update_columns(token: set_token)
  end

  # expire old token
  def fix_up_token
    # FIXME: token age should be configurable
    new_token if updated_at < 1.day.ago
  end

end
