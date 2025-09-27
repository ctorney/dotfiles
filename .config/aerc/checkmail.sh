#!/bin/sh

OFFLINEIMAP=$(pgrep -f offlineimap)
NOTMUCH=$(pgrep -f notmuch)

if [ -n "$OFFLINEIMAP" -o -n "$NOTMUCH" ]; then
  if [ -n "$OFFLINEIMAP" ]; then
    RUNTIME=$(ps -o etime= -p "$OFFLINEIMAP" | awk -F: '{ if (NF==3) {print $1*3600 + $2*60 + $3} else if (NF==2) {print $1*60 + $2} }')
    if [ -n "$RUNTIME" ] && [ "$RUNTIME" -gt 300 ]; then
      echo "Killing stale offlineimap process..."
      kill -9 "$OFFLINEIMAP"
    else
      echo "Already running one instance of offlineimap or notmuch. Exiting..."
      exit 0
    fi
  else
    echo "Already running one instance of offlineimap or notmuch. Exiting..."
    exit 0
  fi
fi

# Actually delete the emails tagged as deleted
# notmuch search --format=text0 --output=files tag:deleted | xargs -0 --no-run-if-empty rm -v

offlineimap
notmuch new
