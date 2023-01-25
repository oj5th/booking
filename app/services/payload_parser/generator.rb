class PayloadParser::Generator
  def initialize(payload)
    @payload = payload
  end

  def run
    {
      reservation: PayloadParser::Reservation.new(@payload).generate,
      guest: PayloadParser::Guest.new(@payload).generate
    }
  end
end
