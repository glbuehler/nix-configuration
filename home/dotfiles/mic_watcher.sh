#!/usr/bin/env bash

trap "exit 0" SIGPIPE

print_mic_apps() {
  src=$(pactl get-default-source)
  mute=$(pactl get-source-mute $src | awk '{print $2}')
  volume=$(pactl get-source-volume $src | awk '{print substr($5, 1, length($5) - 1)}')
  class="muted"
  text="$volume% "
  if [[ $mute = "no" ]]; then
    text="$volume% "
    class="unmuted"
  fi
  apps=$(pactl list source-outputs | awk -F' = ' '/application\.name/ {print substr($2, 2, length($2) - 2)}' | sort)
  tooltip="$src\r$apps"
  
  if [[ "$apps" != "" ]]; then
    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"percentage\": \"$volume\", \"class\": \"$class\"}"
  else
    echo "{ \"text\": \"\" }"
  fi
}

print_mic_apps

id=$(pactl list sources | awk "
  /^Source #/ { id = substr(\$2, 2) }
  /Name:/ && \$2 ~ /$(pactl get-default-source)/ { print id }
")

pactl subscribe | while read -r line; do
  if [[ $line == *" #$id" ]] || [[ $line == *"server"* ]]; then
    print_mic_apps
    id=$(pactl list sources | awk "
      /^Source #/ { id = substr(\$2, 2) }
      /Name:/ && \$2 ~ /$(pactl get-default-source)/ { print id }
    ")
  fi
done
