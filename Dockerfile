FROM ruby:2.7.3 as develop

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm jq
RUN npm install --global yarn

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler:2.2.25

RUN bundle install
RUN yarn install

# Add a script to be executed every time the container starts.
COPY scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
