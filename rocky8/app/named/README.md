# named
named.conf

## 1. Install

### 1.1 Install

    dnf -y install bind bind-utils
            
### 1.2 Edit for named.conf

    vi /etc/named.conf
    
### 1.3 Edit for named

    vi /etc/sysconfig/named
    
    # add to the end
    OPTIONS="-4"

### 1.4 Config for logging
    
    mkdir /var/named/log/
    touch /var/named/log/query.log
    chown -R named:named /var/named/log/
    
    systemctl enable --now named
    systemctl restart named

### 1.5 Testing

    tail -f /var/named/log/query.log
    
    dig www.naver.com
    
### 1.6 setting rules to firewalld

    firewall-cmd --add-service=dns
    
    firewall-cmd --runtime-to-permanent