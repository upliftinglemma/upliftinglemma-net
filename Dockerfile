FROM ruby:2.1.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

# Let the nginx-proxy container know about our app
ENV VIRTUAL_HOST *.upliftinglemma.dev
ENV VIRTUAL_PORT 3000

# Installing common RoR dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      postgresql-client \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3000
CMD ["rails", "server"]
