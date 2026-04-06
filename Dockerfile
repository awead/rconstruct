FROM ruby:3.4

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN bundle install

CMD ["/bin/sleep", "30000"]
