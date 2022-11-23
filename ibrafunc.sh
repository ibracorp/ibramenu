#!/bin/bash
######################################################################
# Title   : IBRAFUNC - IBRAMENU functions
# By      : DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# functions

# message box
msgbox () {
  # function expects a message and optional parameters
  # msgbox <Text> <width of box> <horizontal character for the box> <vertical character for the box>
  # If the box parameters are not given the full width will be used and = for horizontal and | for vertical character

  # checking if message is specified
  if [[ -z $1 ]]; then
    message="Your message could be here"
  else
    message=$1
  fi
  # checking if message box width is specified
  if [[ -z $2 ]]; then
    box_width=$(tput cols)
  else
    box_width=$2
  fi
  # checking if horizontal character is specified
  if [[ -z $3 ]]; then
    box_hor="="
  else
    box_hor=$3
  fi
  # checking if vertical charater is specified
  if [[ -z $4 ]]; then
    box_vert="|"
  else
    box_vert=$4
  fi
  # calculating message box parameters
  msg_length=${#message}
  msg_half=$(( $msg_length / 2 ))
  msg_start=$(( ( ( $box_width - 2 ) / 2 ) - $msg_half ))
  msg_fill_left=$(( $msg_start ))
  msg_fill_right=$(( ( $box_width - 2 ) - $msg_start - $msg_length ))
  # generating strings for box
  box_outline_hor=$(printf %"$box_width"s | tr ' ' "$box_hor")
  msg_space_left=$(printf %"$msg_fill_left"s)
  msg_space_right=$(printf %"$msg_fill_right"s)
  # output
  echo
  echo $box_outline_hor
  echo "$box_vert$msg_space_left$message$msg_space_right$box_vert"
  echo $box_outline_hor
  echo
}
