##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.5.1]
- Rails [5.2.8]
- Postgresql
- Postman

##### 1. Check out the repository

```bash
git clone git@github.com:oj5th/booking.git
```

##### 2. Setup database.yml file

Edit the database configuration as required with your postgresql username and password.

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rails db:create
bundle exec rails db:migrate
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the api using postman with the URL http://localhost:3000

##### 5. API Enpoints

##### Get all guests with reservations

> GET /reservations

##### Create Guest with Reservations

> POST /reservations

Sample Payload 1:
```shell
{
  "reservation_code": "YYY12345678",
  "start_date": "2021-04-14",
  "end_date": "2021-04-18",
  "nights": 4,
  "guests": 4,
  "adults": 2,
  "children": 2,
  "infants": 0,
  "status": "accepted",
  "guest": {
    "first_name": "Wayne",
    "last_name": "Woodbridge",
    "phone": "639123456789",
    "email": "wayne_woodbridge@bnb.com"
  },
  "currency": "AUD",
  "payout_price": "4200.00",
  "security_price": "500",
  "total_price": "4700.00"
}
```


Sample Payload 2:
```shell
{
  "reservation": {
    "code": "XXX12345678",
    "start_date": "2021-03-12",
    "end_date": "2021-03-16",
    "expected_payout_amount": "3800.00",
    "guest_details": {
      "localized_description": "4 guests",
      "number_of_adults": 2,
      "number_of_children": 2,
      "number_of_infants": 0
    },
    "guest_email": "wayne_woodbridge@bnb.com",
    "guest_first_name": "Wayne",
    "guest_last_name": "Woodbridge",
    "guest_phone_numbers": [
      "639123456789",
      "639123456789"
    ],
    "listing_security_price_accurate": "500.00",
    "host_currency": "AUD",
    "nights": 4,
    "number_of_guests": 4,
    "status_type": "accepted",
    "total_paid_amount_accurate": "4300.00"
  }
}
```

##### Update Reservations Details
Note: I added update for phone numbers, I noticed that `phone number` key for payload 1 is different with payload 2.

> PUT /reservations

```shell
Payload is same with POST Request, you can try both payload and try also to change `guest_phone_numbers` values or `phone` values to see the difference.
```

##### GET Specific Reservation
This is just created to check the changes made for PUT and POST request.

> GET /reservations/#{reservation_id}




