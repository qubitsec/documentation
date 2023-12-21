# Chrony
chrony conf

## 1. Install

### 1.1 Install

    dnf -y install chrony
            
### 1.2 Edit for chrony

    vi /etc/chrony.conf 
    
    server 172.16.10.250 iburst
    allow 10.10.10.0/23
    allow 192.168.0.0/16
    
    systemctl enable --now chronyd

    systemctl restart chronyd

### 1.3 Testing

    chronyc sources
    
    dnf -y install ntpstat
    
    ntpstat
    

### 1.4 setting rules to firewalld

    firewall-cmd --add-service=ntp --permanent
    
    firewall-cmd --reload

