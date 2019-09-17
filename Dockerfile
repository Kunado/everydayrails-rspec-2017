FROM ruby:2.6.3-alpine

RUN mkdir -p /var/www/app
WORKDIR /var/www/app

COPY Gemfile* ./

COPY package.json ./
COPY yarn.lock ./

RUN apk upgrade && \
    apk add --no-cache --update \
      yarn \
      tzdata \
      sqlite-dev \
      libc-dev \
      curl-dev \
      libxml2-dev \
      make \
      gcc \
      g++ \
      git && \
    gem install bundler && \
    bundle install -j4 && \
    yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]