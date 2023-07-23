# Use the official Ruby 3.1.2 image as the base image
FROM ruby:3.1.2

# Install libvips for Active Storage preview support
RUN apt-get update -qq && \
	apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata nodejs npm yarn && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

RUN mkdir rails
WORKDIR /rails

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
	RAILS_SERVE_STATIC_FILES="true" \
	RAILS_ENV="production" \ 
	BUNDLE_WITHOUT="development"


COPY Gemfile* ./
RUN bundle install
COPY . .

RUN chmod +x bin/entrypoint
ENTRYPOINT ["bin/entrypoint"]

# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
