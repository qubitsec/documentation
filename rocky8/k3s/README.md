## 1. K3s

### 1.1 master

```
curl -sfL https://get.k3s.io | sh -s - server \
  --cluster-init \
  --datastore-endpoint='mysql://k3s:password@tcp(10.10.11.229:3306)/k3s' > install.log 2>&1
```

### 1.2 add to master

```
curl -sfL https://get.k3s.io | K3S_TOKEN=<token> sh -s - server
--datastore-endpoint="mysql://k3s:password@tcp(10.10.11.229:3306)/k3s"
--server https://10.10.11.220:6443
```

### 1.3 Create for services

```
vi /etc/nagios/objects/services.cfg

# new
define service{
        name                            check_url-service         ; The 'name' of this service template
        active_checks_enabled           1                       ; Active service checks are enabled
        passive_checks_enabled          1                       ; Passive service checks are enabled/accepted
        parallelize_check               1                       ; Active service checks should be parallelized (disabling this can lead to major performance problems)
        obsess_over_service             1                       ; We should obsess over this service (if necessary)
        check_freshness                 0                       ; Default is to NOT check service 'freshness'
        notifications_enabled           1                       ; Service notifications are enabled
        event_handler_enabled           1                       ; Service event handler is enabled
        flap_detection_enabled          1                       ; Flap detection is enabled
        process_perf_data               1                       ; Process performance data
        retain_status_information       1                       ; Retain status information across program restarts
        retain_nonstatus_information    1                       ; Retain non-status information across program restarts
        is_volatile                     0                       ; The service is not volatile
        check_period                    24x7                    ; The service can be checked at any time of the day
        max_check_attempts              3                       ; Re-check the service up to 3 times in order to determine its final (hard) state
        check_interval                  10                      ; Check the service every 10 minutes under normal conditions
        retry_interval                  2                       ; Re-check the service every two minutes until a hard state can be determined
        contact_groups                  admins                  ; Notifications get sent out to everyone in the 'admins' group
        notification_options            w,u,c,r                 ; Send notifications about warning, unknown, critical, and recovery events
        notification_interval           60                      ; Re-notify about service problems every hour
        notification_period             24x7                    ; Notifications can be sent out at any time
        register                        0                       ; DONT REGISTER THIS DEFINITION - ITS NOT A REAL SERVICE, JUST A TEMPLATE!
        }
```

## 2. Register

### 2.1 Register for http_check

```
mkdir /etc/nagios/servers/
```

```
vi /etc/nagios/servers/www.plura.io.cfg

define host{
    use                     linux-server
    host_name               www.plura.io
    alias                   PLURA
    address                 211.43.190.20
    max_check_attempts      5
    check_period            24x7
    notification_interval   30
    notification_period     24x7
    hostgroups              PLURA
}

define service{
    use                     check_url-service
    host_name               www.plura.io
    service_description     HTTPS Check
    check_command           check_http!-S -p 443 -C 30 ; Certificate check expire after 30 days
    notifications_enabled   1
}
```
<hr/>

### 2.2 Register for http_check

```
vi /etc/nagios/servers/uploadweb.plura.io.cfg

define host{
    use                     linux-server
    host_name               uploadweb.plura.io
    alias                   PLURA
    address                 211.43.190.60
    max_check_attempts      5
    check_period            24x7
    notification_interval   30
    notification_period     24x7
    hostgroups              PLURA
}

define service{
    use                     check_url-service
    host_name               uploadweb.plura.io
    service_description     HTTPS Check
    check_command           check_http!-S -p 443 -u /PATH -C 400 ; Certificate check expire after 400 days
    notifications_enabled   1
}
```

### 2.3 Restart

```
systemctl restart nagios
```

<hr/>

### 3.1 Change main.php to services

```
cd /usr/share/nagios/html/

cp index.php index.php.bak
```

```
vi index.php

<?php
// Allow specifying main window URL for permalinks, etc.
//$url = 'main.php';
$url = '/nagios/cgi-bin/status.cgi?host=all';
```

## X. Useful Links

- https://www.server-world.info/en/note?os=CentOS_Stream_8&p=nagios&f=1
