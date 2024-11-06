# Extend from the official Elixir image
FROM elixir:alpine

EXPOSE 4000

ARG mix_env
ARG get_deps
# Install required libraries on Alpine
# note: build-base required to run mix “make” for
# one of my dependecies (bcrypt)

RUN apk update && apk upgrade && \
  apk add postgresql-client && \
  apk add nodejs npm && \
  apk add build-base && \
  apk add git && \
  rm -rf /var/cache/apk/*

# Set environment to production
ENV MIX_ENV ${mix_env}

# Install hex package manager and rebar
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix do local.hex --force, local.rebar --force

# Cache elixir dependecies and lock file
COPY mix.* ./

# Install and compile production dependecies
RUN mix do ${get_deps} 
RUN mix deps.compile

# Cache and install node packages and dependencies
# COPY assets/package.json assets/
# RUN cd assets && \
#     npm install

# Copy all application files
COPY . ./

# Run frontend build, compile, and digest assets

# RUN cd assets/ && \
#     npm run deploy && \
#     cd - &&
RUN mix do compile, phx.digest

# Run entrypoint.sh script
RUN chmod +x entrypoint.sh
CMD ["/entrypoint.sh"]
