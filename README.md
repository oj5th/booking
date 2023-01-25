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

### Get all guests with reservations

GET /reservations

```shell
GET /reservations
```
