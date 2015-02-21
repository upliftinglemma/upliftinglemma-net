FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /upliftinglemma-net
WORKDIR /upliftinglemma-net
ADD Gemfile /upliftinglemma-net/Gemfile
ADD Gemfile.lock /upliftinglemma-net/Gemfile.lock
RUN bundle install
ADD . /upliftinglemma-net

