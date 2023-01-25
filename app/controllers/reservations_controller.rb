class ReservationsController < ApplicationController
  def index
    guest_with_reservation = Guest.includes(:reservations)
    render json: { data: guest_with_reservation.map { |resultset|
                                                      {
                                                        guest: resultset,
                                                        reservations: resultset.reservations
                                                      }
                                                    }
                  }
  end

  def create
    @current_guest = Guest.find_by(email: generated_payload_guest[:email])
    if @current_guest.present?
      current_guest_create_reservation
    else
      create_guest_and_reservation
    end
  end

  def show
    if Reservation.exists?(params[:id])
      reservation = Reservation.find(params[:id])
      render json: { reservation: reservation, guest: reservation.guest }
    else
      render json: { message: "Reservation id: #{params[:id]} not found.", status_code: 404 }, status: :not_found
    end
  end

  def update
    reservation_with_guest = Reservation.includes(:guest)
      .where(
        reservations: {code: generated_payload_reservation[:code]},
        guests: {email: generated_payload_guest[:email]}
      )

    if reservation_with_guest.present?
      current_reservation = reservation_with_guest.first
      current_guest = current_reservation.guest

      if current_reservation.update_attributes(
        start_date:         generated_payload_reservation[:start_date],
        end_date:           generated_payload_reservation[:end_date],
        number_of_nights:   generated_payload_reservation[:number_of_nights],
        number_of_guests:   generated_payload_reservation[:number_of_guests],
        number_of_adults:   generated_payload_reservation[:number_of_adults],
        number_of_children: generated_payload_reservation[:number_of_children],
        number_of_infants:  generated_payload_reservation[:number_of_infants],
        status:             generated_payload_reservation[:status],
        currency:           generated_payload_reservation[:currency],
        payout_price:       generated_payload_reservation[:payout_price],
        security_price:     generated_payload_reservation[:security_price],
        total_price:        generated_payload_reservation[:total_price]
        )

        # Additonal, update for phone if changed on payload
        # If Guest.phone_numbers is NOT EQUAL with phone number from payload
        # Then update the phone number from guest.
        # In 2 sample payloads it can be different values
        same_phone_numbers = current_guest.phone_numbers & generated_payload_guest[:phone_numbers]
        if (current_guest.phone_numbers - same_phone_numbers).count > 0 || (generated_payload_guest[:phone_numbers] - same_phone_numbers).count > 0
          current_guest.update_attributes(phone_numbers: generated_payload_guest[:phone_numbers])
        end
        render json: { message: "Reservation successfully updated!", status_code: 200 }, status: :ok
      else
        render json: { message: current_reservation.errors, status_code: 422 }, status: :unprocessable_entity
      end
    else
      render json: { message: "Email #{generated_payload_guest[:email]} or/and reservation code: #{generated_payload_reservation[:code]} not found", status_code: 404 }, status: :not_found
    end
  end

  private
    def current_guest_create_reservation
      @reservation = @current_guest.reservations.new(generated_payload_reservation)
      if @reservation.save
        render json: {
          message: "Reservation successfully saved!",
          status_code: 201,
          guest: generated_payload_guest,
          reservation: generated_payload_reservation
        },
        status: :created
      else
        render json: { message: @reservation.errors, status_code: 422 }, status: :unprocessable_entity
      end
    end

    def create_guest_and_reservation
      @guest = Guest.new(generated_payload_guest)
      @guest.reservations.build(generated_payload_reservation)
      if @guest.save
        render json: {
          message: "Reservation successfully saved!",
          status_code: 201,
          guest: generated_payload_guest,
          reservation: generated_payload_reservation
        },
        status: :created
      else
        render json: { message: @guest.errors, status_code: 422 }, status: :unprocessable_entity
      end
    end

    def generated_payload
      PayloadParser::Generator.new(params).run
    end

    def generated_payload_reservation
      generated_payload[:reservation]
    end

    def generated_payload_guest
      generated_payload[:guest]
    end
end
