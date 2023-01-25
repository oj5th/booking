class PayloadParser::Guest
  def initialize(guest_payload)
    @guest_payload = guest_payload
  end

  def generate
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      phone_numbers: phone_numbers
    }
  end

  private

    def email
      guest_fields("reservation,guest_email") || guest_fields("guest,email")
    end

    def first_name
      guest_fields("reservation,guest_first_name") || guest_fields("guest,first_name")
    end

    def last_name
      guest_fields("reservation,guest_last_name") || guest_fields("guest,last_name")
    end

    # Cleanup phone numbers first, need to check duplicate phone numbers added
    def phone_numbers
      input_phone_numbers.uniq
    end

    def input_phone_numbers
      guest_fields("reservation,guest_phone_numbers") || [guest_fields("guest,phone")]
    end

    def guest_fields(param)
      @guest_payload.dig(*(param).split(',').map(&:to_sym))
    end
end
