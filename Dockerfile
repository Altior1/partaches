FROM elixir:1.19.5

# Install Hex + Rebar
RUN mix deps.get --only=prod && mix local.hex --force && mix local.rebar --force

# lance le setup de l'application
RUN mix setup

# Compile l'application
RUN mix compile

# Expose the port the app runs on
EXPOSE 4000

# Start the application
CMD ["mix", "phx.server"]