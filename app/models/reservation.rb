class Reservation < ApplicationRecord
  attr_accessor :update
  belongs_to :guest
  validates_uniqueness_of :code
  validate :end_date_is_after_start_date
  validate :nights_count
  validate :number_of_guests_count

  private
    def end_date_is_after_start_date
      if end_date < start_date
        errors.add(:end_date, "Cannot be before the start date.")
      end
    end

    def nights_count
      if ((start_date.to_date..end_date.to_date).count) != number_of_nights
        errors.add(:number_of_nights, "Number of nights is not equal from start date to end date.")
      end
    end

    def number_of_guests_count
      if (number_of_adults + number_of_children + number_of_infants) != number_of_guests
        errors.add(:number_of_guests, "Number of guests is not equal from number of adults, children and infants count.")
      end
    end
end
