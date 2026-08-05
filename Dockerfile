# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=4.0.6
ARG BUNDLER_VERSION=4.0.18
ARG BASE_PACKAGES="curl libjemalloc2"
ARG BUILD_PACKAGES="git build-essential libpq-dev wget vim curl gzip default-libmysqlclient-dev libyaml-dev"

# ------------------------
FROM ruby:$RUBY_VERSION-slim-bookworm AS base

ARG BASE_PACKAGES
ARG BUNDLER_VERSION

LABEL fly_launch_runtime="rails"
WORKDIR /rails

RUN gem update --system --no-document && \
    gem install -N bundler -v ${BUNDLER_VERSION}

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y ${BASE_PACKAGES} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_ENV="production"

# ------------------------
FROM base AS build

ARG BUILD_PACKAGES

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y ${BUILD_PACKAGES} && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile
COPY . .

RUN bundle exec bootsnap precompile app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ------------------------
FROM base AS production

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp /data && \
    chown -R 1000:1000 db log storage tmp public /data
USER 1000:1000

# Default server start instructions.  Generally Overridden by fly.toml.
ENV PORT=8080
ARG SERVER_COMMAND="bin/rails fly:server"
ENV SERVER_COMMAND=${SERVER_COMMAND}
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["bin/rails", "fly:server"]
