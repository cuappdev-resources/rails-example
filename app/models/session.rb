# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :code

  def save_with_session_code
    set_code
    self.save
  end

  private
  def set_code
    self.code = SecureRandom.urlsafe_base64
  end
end
