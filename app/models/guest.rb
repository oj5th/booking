class Guest < ApplicationRecord
  has_many :reservations
  accepts_nested_attributes_for :reservations

  validates_uniqueness_of :email
end
