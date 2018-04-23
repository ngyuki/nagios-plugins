#!/bin/bash

<<__COMMENT__
define command {
    command_name    notify-service-by-email
    command_line    URL="http://example.com/nagios/" \
                    FROM="$CONTACTADDRESS1$" \
                    CONTACTEMAIL="$CONTACTEMAIL$" \
                    HOSTADDRESS="$HOSTADDRESS$" \
                    HOSTALIAS="$HOSTALIAS$" \
                    LONGDATETIME="$LONGDATETIME$" \
                    NOTIFICATIONTYPE="$NOTIFICATIONTYPE$" \
                    SERVICEDESC="$SERVICEDESC$" \
                    SERVICEOUTPUT="$SERVICEOUTPUT$" \
                    SERVICESTATE="$SERVICESTATE$" \
                    /etc/nagios/scripts/notify-service-by-email.sh
}
__COMMENT__
################################################################################

/usr/bin/mail \
  -s "** $NOTIFICATIONTYPE Service Alert: $HOSTALIAS/$SERVICEDESC is $SERVICESTATE **" \
  -r "${FROM:-nagios}" "${CONTACTEMAIL?}" \
<<EOS
***** Nagios *****

Notification Type: $NOTIFICATIONTYPE

Service: $SERVICEDESC
Host: $HOSTALIAS
Address: $HOSTADDRESS
State: $SERVICESTATE

Date/Time: $LONGDATETIME

Additional Info:

$SERVICEOUTPUT

--

Nagios: $URL
EOS
