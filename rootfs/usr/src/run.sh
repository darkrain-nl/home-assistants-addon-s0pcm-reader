#!/usr/bin/env bashio
set -e

MEASUREMENT="/data/config/measurement.yaml"

# Initialize measurement.yaml
meter1=$(bashio::config 'meter_1')
meter2=$(bashio::config 'meter_2')

{
    echo date: $(date '+%Y-%m-%d')
    echo "1:"
    echo "  pulsecount: 0"
    echo "  today: 0"
    echo "  total: ${meter1}"
    echo "  yesterday: 0"
    echo "2:"
    echo "  pulsecount: 0"
    echo "  today: 0"
    echo "  total: ${meter2}"
    echo "  yesterday: 0"
} > "${MEASUREMENT}"

# Copy example configuration if not exists
if [ ! -f /data/config/configuration.json ]; then
  cp /usr/src/configuration.json.example /data/config/configuration.json
fi

python /usr/src/s0pcm-reader.py -c /data/config

if [ -f /data/config/.noexit ]; then
  sleep 7d
fi