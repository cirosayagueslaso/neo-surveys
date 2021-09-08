# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable,
         :registerable,
         :recoverable, :rememberable,
         :validatable, :confirmable

  validates :name, :email, presence: true

  after_create :send_confirmation_email

  private

  def send_confirmation_email
    self.send_confirmation_instructions
  end
end
