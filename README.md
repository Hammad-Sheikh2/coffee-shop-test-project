# Coffee Shop

This is a Rails application for a coffee shop that allows customers to place orders and view the menu. The application uses a PostgreSQL database and the `jsonapi_serializer` gem to serialize data for the APIs.

## Prerequisites

- Ruby 3.1.2
- Rails 7.0.5
- PostgreSQL 12.15

## Getting Started

1. Navigate to the project directory: `cd coffee-shop`
2. Install the required gems: `bundle install`
3. Set credentials: `EDITOR=nano rails credentials:edit`
  ```
    database_username: your_username
    database_password: your_password
    mailer_url_options: { host, port }
    smtp: your_smtp_secrets
    secret_key_base: long_random_string
  ```
4. Create the database: `rails db:create`
5. Run the database migrations: `rails db:migrate`
6. Seed the database with sample data (optional): `rails db:seed`
7. Start the server: `rails s`
