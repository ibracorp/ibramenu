#!/bin/bash
######################################################################
# Title   : IBRAMENU Supporter Menu
# By      : Sycotix, DiscDuck
# License : General Public License GPL-3.0-or-later
# Another fine product brought to you by IBRACORP™
######################################################################

# Include ibrafunc for all the awesome functions
source /opt/ibracorp/ibramenu/ibrafunc.sh

# Define
tokenfile="/opt/ibracorp/token"
token=""
check_token="invalid"
check_access="invalid"

# Check for local token file
check_token() {
  if [ -f $tokenfile ]; then
    check_token="valid"
  fi
}

# Check if token grants access
check_access() {
  token=$(cat $tokenfile)
  access=$(curl -u ibracorp:$token -s https://raw.githubusercontent.com/ibracorp/ibramenu-supporter/main/ACCESS | cat)
  if [ "$access" = "validated" ]; then
    check_access="valid"
  fi
}

# Become a supporter
become_a_supporter() {
  ibralogo
  echo
  if [ "$check_token" = "invalid" ]; then
    echo "There is no token set on your system and therefore no"
    echo "access to the IBRAMENU Supporter Menu is available."
  else
    echo "There is a token set on your system, but it is not valid"
    echo "to access the IBRAMENU Supporter Menu."
  fi
  msgbox "Become a Supporter"
  tee <<-EOF
What's Included

Help support our work at IBRACORP (and the developers of IBRAMENU)
by buying the supporter edition of IBRAMENU for a one-time purchase.
This purchase will provide you with the limited edition
Supporter Edition of IBRAMENU.

This version allows everything the free version does plus:

Access to the exclusive IBRAMENU Supporter Channel on our
IBRACORP Discord Server
Exclusive automation within the already available menu options
The following perks are included and are valid for one year after
purchase and will need to be renewed if you choose to (optional):

* Priority updates to receive the latest version of IBRAMENU Beta
  access to early release versions
* Discord perks and roles (optional - please remember to add your
  Discord details on checkout!)
* VIP access to supporter-only Discord channels
* Exclusive supporter role for IBRAMENU
* Your voice is heard in future development and function

Most importantly, by purchasing this option you are helping support our
work put in to develop and maintain IBRAMENU and we greatly appreciate
your support.

Visit https://ibramenu.io/product/ibramenu-supporter-package/
EOF
}

# Request token and store local
request_local_token() {
  read -p "Please enter your personal IBRAMENU Supporter token: " token
  echo "$token" >"$tokenfile"
}

check() {
  check_token
  if [ $check_token = "valid" ]; then
    check_access
  fi
}

# Execute
check
if [ "$check_token" = "valid" ] && [ "$check_access" = "valid" ]; then
  ibramenusupporter="/opt/ibracorp/ibramenu-supporter"
  if [ -d "$ibramenusupporter" ]; then
    rm -r "$ibramenusupporter"
  fi
  git clone -b main --single-branch https://oauth2:$token@github.com/ibracorp/ibramenu-supporter.git "$ibramenusupporter"
  find "$ibramenusupporter" -type f -iname "*.sh" -exec chmod +x {} \;
  /opt/ibracorp/ibramenu/ibramenu.sh "$ibramenusupporter/MenuOptions/"
else
  become_a_supporter
  echo
  request_local_token
fi
