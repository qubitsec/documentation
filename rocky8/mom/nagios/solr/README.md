## 1. Solr


### 1.1 Run and Stop
```
chmod a+x /usr/lib64/nagios/plugins/check_solr_status.sh
```
```
nagios -v /etc/nagios/nagios.cfg
```
```
systemctl restart nagios
```

### 2.0 Config

```
vi /etc/nagios/objects/services.cfg

define service{
        name                            solr-status-service         ; The 'name' of this service template
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

<hr/>

```
vi /etc/nagios/objects/hostgroups.cfg

define hostgroup {
        hostgroup_name          solr-status
        alias                   solr
}
```

<hr/>

```
vi /etc/nagios/objects/commands.cfg

################################################################################
#
# Solr HOST CHECK COMMANDS
#
################################################################################

define command{
    command_name check_solr_status
    command_line $USER1$/check_solr_status.sh
}
```

<hr/>

```
vi /etc/nagios/objects/commands.cfg

################################################################################
#
# Solr HOST CHECK COMMANDS
#
################################################################################

define command{
    command_name check_solr_status
    command_line $USER1$/check_solr_status.sh
}
```
<hr/>

```
vi /etc/nagios/servers/solr-syslog-status.cfg

define host{
    use                     linux-server
    host_name               solr-status
    alias                   solr-status
    address                 10.10.10.69
    hostgroups              solr-status
}

define service {
        use                     solr-status-service
        host_name               solr-status
        service_description     Solr status
        check_command           check_solr_status!8983!syslog
}
```
