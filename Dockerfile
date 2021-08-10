FROM ruby:2.7

WORKDIR /app

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt-get install -y nodejs && \
  npm install --global yarn

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs $(nproc)

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
