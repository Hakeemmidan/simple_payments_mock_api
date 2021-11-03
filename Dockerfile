FROM ruby:2.7.2
# Set TERM env to avoid error message "TERM environment variable not set"
ENV TERM=xterm

RUN apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
  postgresql-client \
  nodejs \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

# Pre-install gems with native extensions
RUN gem install nokogiri -v "1.6.8.1"

# Install cmake
RUN apt-get update && apt-get -y install cmake protobuf-compiler

# Bundle install gems
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD rails server -b 0.0.0.0 -P /tmp/puma.pid
