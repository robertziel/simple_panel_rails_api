FROM ruby:2.6.3
ENV LANG C.UTF-8

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD .ruby-version .ruby-version
RUN bundle install

ENV APP_HOME /myapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
