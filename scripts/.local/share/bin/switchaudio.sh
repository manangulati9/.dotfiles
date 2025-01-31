#!/bin/bash

# Get the list of sinks
sink_ids=($(pactl list short sinks | cut -f1))
sink_names=($(pactl list short sinks | cut -f2))

# Get the index of the current default sink in our array
current_index=-1
for i in "${!sink_names[@]}"; do
  if [[ "$(pactl get-default-sink)" == *"${sink_names[$i]}"* ]]; then
    current_index=$i
    break
  fi
done

# Switch to the other sink (between first two)
if [[ $current_index -eq 0 ]]; then
  new_sink=${sink_ids[1]}
else
  new_sink=${sink_ids[0]}
fi

# Set the new default sink
pactl set-default-sink "$new_sink"
