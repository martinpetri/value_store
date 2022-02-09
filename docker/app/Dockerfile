FROM ruby:3.0.3-alpine

ENV RAILS_ROOT /app

RUN apk update && apk add --no-cache wget bash curl

RUN wget https://nodejs.org/dist/v16.8.0/node-v16.8.0-linux-x64.tar.xz && tar -xf node-v16.8.0-linux-x64.tar.xz

RUN apk add yarn --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \
  yarn install && \
  apk del yarn

RUN apk add \
  build-base \
  nodejs \
  yarn \
  libpq-dev \
  tzdata && \
  mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT

ENV RAILS_ENV='production'
ENV SECRET_KEY_BASE='2602e3fba52ad66fcef930dcf59ad9210d3e1a1aceadd6077c7498d05519656c9face8929c52708b06d3c5de98f3e8d397f2993324c6f6c1750635214e20c040'
ENV COMPOSE_PROJECT_NAME='value_store'
ENV POSTGRES_USER='postgres'
ENV POSTGRES_PASSWORD='postgres'
ENV REDIS_URL=redis://redis
ENV RAILS_SERVE_STATIC_FILES=false

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle config set --jobs 20 --retry 5 --local without 'development test'

COPY package.json package.json
COPY yarn.lock yarn.lock

RUN yarn install --check-files

COPY . .

RUN gem update --system
RUN gem update bundler
RUN bundle install

RUN bundle exec rails assets:precompile

# EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
#CMD ["bundle", "exec", "rails", "s"]

