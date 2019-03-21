FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick ibmagick++-dev sqlite3
RUN mkdir /myapp
RUN gem install bundler
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
RUN rails db:migrate
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]