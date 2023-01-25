class PayloadParser::Reservation
  def initialize(payload)
    @payload = payload
  end

  def generate
    {
      code: code,
      start_date: start_date,
      end_date: end_date,
      number_of_nights: number_of_nights,
      number_of_guests: number_of_guests,
      number_of_adults: number_of_adults,
      number_of_children: number_of_children,
      number_of_infants: number_of_infants,
      status: status,
      currency: currency,
      payout_price: payout_price,
      security_price: security_price,
      total_price: total_price
    }
  end

  private

    def code
      get_values("reservation,code") || get_values("reservation_code")
    end

    def start_date
      get_values("reservation,start_date") || get_values("start_date")
    end

    def end_date
      get_values("reservation,end_date") || get_values("end_date")
    end

    def number_of_nights
      get_values("reservation,nights") || get_values("nights")
    end

    def number_of_guests
      get_values("reservation,number_of_guests") || get_values("guests")
    end

    def number_of_adults
      get_values("reservation,guest_details,number_of_adults") || get_values("adults")
    end

    def number_of_children
      get_values("reservation,guest_details,number_of_children") || get_values("children")
    end

    def number_of_infants
      get_values("reservation,guest_details,number_of_infants") || get_values("infants")
    end

    def status
      get_values("reservation,status_type") || get_values("status")
    end

    def currency
      get_values("reservation,host_currency") || get_values("currency")
    end

    def payout_price
      get_values("reservation,expected_payout_amount") || get_values("payout_price")
    end

    def security_price
      get_values("reservation,listing_security_price_accurate") || get_values("security_price")
    end

    def total_price
      get_values("reservation,total_paid_amount_accurate") || get_values("total_price")
    end

    def get_values(param)
      @payload.dig(*(param).split(',').map(&:to_sym))
    end
end
