# Use the official Ruby 3.1.2 image as the base image
FROM ruby:3.1.2

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the environment variables
ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler:2.2.28 && bundle config set --local without 'development test' && bundle install --jobs 20 --retry 5

# Copy the rest of the application code into the container
COPY . .

# Copy credentials.yml.enc to the container
COPY config/credentials.yml.enc config/master.key ./

# Set up the database configuration
RUN bundle exec rails credentials:edit

# Create the database and run migrations
RUN bundle exec rails db:create db:migrate

# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
