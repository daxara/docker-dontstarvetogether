#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -e

# Use the `steamcmd` command if only options were given.
if [ "${1:0:1}" = '+' ]; then
	set -- steamcmd "$@"
fi


# Run start command if only options given.
if [[ "${1:0:1}" = '-' ]]; then
	set -- dst-server start "$@"
fi

# Handle running the steamcmd command.
if [ "$1" = 'steamcmd' ]; then

	# Run via steam user.
	set -- su $STEAM_USER "$@"
fi

# Run boot scripts before starting the server.
if [[ "$1" = 'dst-server' ]]; then

	# Prepare the shard directory.
	mkdir -p "$CLUSTER_PATH/$SHARD_NAME"
	chown -R "$STEAM_USER":"$STEAM_USER" "$CLUSTER_PATH"

	# Run via steam user if the command is `dst-server`.
	set -- su "$STEAM_USER" "$@"
fi

# Execute the command.
exec "$@"
