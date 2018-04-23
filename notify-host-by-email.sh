#!/bin/bash

<<__COMMENT__
define command {
    command_name    notify-host-by-email
    command_line    URL="http://example.com/nagios/" \
                    FROM="$CONTACTADDRESS1$" \
                    CONTACTEMAIL="$CONTACTEMAIL$" \
                    HOSTADDRESS="$HOSTADDRESS$" \
                    HOSTALIAS="$HOSTALIAS$" \
                    HOSTOUTPUT="$HOSTOUTPUT$" \
                    HOSTSTATE="$HOSTSTATE$" \
                    LONGDATETIME="$LONGDATETIME$" \
                    NOTIFICATIONTYPE="$NOTIFICATIONTYPE$" \
                    /etc/nagios/scripts/notify-host-by-email.sh
}
__COMMENT__
################################################################################

/usr/bin/mail \
  -s "** $NOTIFICATIONTYPE Host Alert: $HOSTALIAS is $HOSTSTATE **" \
  -r "${FROM:-nagios}" "${CONTACTEMAIL?}" \
<<EOS
***** Nagios *****

Notification Type: $NOTIFICATIONTYPE

Host: $HOSTALIAS
State: $HOSTSTATE
Address: $HOSTADDRESS
Info: $HOSTOUTPUT

Date/Time: $LONGDATETIME

--

Nagios: $URL
EOS
