FROM elixir:1.19.5

ARG POSTGRES_PWD
ARG POSTGRES_USER
ARG POSTGRES_DB
ARG POSTGRES_HOST
ARG POSTGRES_PORT

ENV POSTGRES_PWD=$POSTGRES_PWD
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_HOST=$POSTGRES_HOST
ENV POSTGRES_PORT=$POSTGRES_PORT

COPY . /app
WORKDIR /app

# Install les dépendances système nécessaires
RUN mix deps.get

# lance le setup de l'application
RUN mix setup

# Compile l'application
RUN mix compile

# Expose the port the app runs on
EXPOSE 4000

# Start the application
CMD ["mix", "phx.server"]