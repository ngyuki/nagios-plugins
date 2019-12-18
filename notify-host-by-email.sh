#!/bin/bash

<<__COMMENT__
define command {
    command_name    notify-host-by-email
    command_line    FOOTER="Nagios: http://example.com/nagios/" \
                    FROM="$CONTACTADDRESS1$" \
                    CONTACTEMAIL="$CONTACTEMAIL$" \
                    HOSTADDRESS="$HOSTADDRESS$" \
                    HOSTALIAS="$HOSTALIAS$" \
                    HOSTOUTPUT="$HOSTOUTPUT$" \
                    LONGHOSTOUTPUT="$LONGHOSTOUTPUT$" \
                    HOSTSTATE="$HOSTSTATE$" \
                    SHORTDATETIME="$SHORTDATETIME$" \
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
Date/Time: $SHORTDATETIME

Additional Info:

$HOSTOUTPUT
$LONGHOSTOUTPUT

--
$FOOTER
EOS
