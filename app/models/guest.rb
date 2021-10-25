class Guest < ApplicationRecord
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  serialize :phone, Array

  has_many :reservations, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email, :phone
  validates_uniqueness_of :email
  validates_format_of :email, with: EMAIL_FORMAT
end
