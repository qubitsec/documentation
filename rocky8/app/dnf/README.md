# dnf

### 1.1 Clean

    rm -f /var/lib/rpm/__*
    rpm --rebuilddb -v -v
    dnf clean all
    rm -rf /var/cache/dnf
    dnf makecache
    
    dnf -y update
            
### 1.2 Clean yum

    rm -f /var/lib/rpm/__*
    rpm --rebuilddb -v -v
    yum clean all
    rm -rf /var/cache/yum
    yum makecache
    
    yum -y update
