FROM ruby:2.2.0

RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.2:3142";' >> /etc/apt/apt.conf.d/01proxy \
  && echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update -qq
RUN apt-get install -qy curl nodejs libmysqlclient-dev libsqlite3-dev build-essential ruby2.1 ruby2.1-dev
ENV APP_HOME /rails
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN bundle install
ADD . $APP_HOME
