# Use the official Ruby 3.2.2 image as a base
FROM ruby:3.2.2-slim-bullseye

# Set the working directory for the Rails app inside the container
WORKDIR /app/rails

# Install essential packages required for building gems
RUN apt-get update -qq && apt-get install -y build-essential libvips

# Copy the Gemfile and Gemfile.lock from your local `rails` subfolder
COPY rails/Gemfile rails/Gemfile.lock ./

# Install your application's gems
RUN bundle install

# Copy the rest of your Rails application code into the container
COPY rails/ .

# Expose port 3000 to allow communication with the Rails server
EXPOSE 3000

# Set the default command to run when the container starts
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
