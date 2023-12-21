# Repo
for local

## 0. Clean

### 0.1 Install

    rm -f /var/lib/rpm/__*
    rpm --rebuilddb -v -v
    dnf clean all
    rm -rf /var/cache/dnf
    
    dnf makecache
    dnf -y update

## 1. Install

### 1.1 Install

    dnf -y install yum-utils createrepo
            
### 1.2 Create directories for repository

    mkdir -p /var/www/repos/rocky/8/x86_64/os
    
    chmod -R 755 /var/www/repos

### 1.3 copy from official repository

    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=baseos --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=appstream --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --repo=extras --download-metadata
    
### 1.4 create repodata

    createrepo /var/www/repos/rocky/8/x86_64/os/appstream/
    
    createrepo /var/www/repos/rocky/8/x86_64/os/baseos/
    
    createrepo /var/www/repos/rocky/8/x86_64/os/extras/

### 1.5 update from official repository

    reposync -p /var/www/repos/rocky/8/x86_64/os/ --newest-only --repo=baseos --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --newest-only --repo=appstream --download-metadata
    
    reposync -p /var/www/repos/rocky/8/x86_64/os/ --newest-only --repo=extras --download-metadata

### 1.6 update repodata

    createrepo --update /var/www/repos/rocky/8/x86_64/os/appstream/
    
    createrepo --update /var/www/repos/rocky/8/x86_64/os/baseos/
    
    createrepo --update /var/www/repos/rocky/8/x86_64/os/extras/

### 1.7 selinux

    restorecon -r /var/www/repos/

### 1.8 setting rules to firewalld

    firewall-cmd --add-service=httpd --permanent
    
    firewall-cmd --reload

### 1.9 testing

    dnf repolist

    dnf module list

## 2. EPEL

### 2.1 Create directories for repository

    mkdir -p /var/www/repos/rocky/epel/8/Everything/x86_64/
    
    chmod -R 755 /var/www/repos

### 2.2 copy from official repository

    reposync -p /var/www/repos/rocky/epel/8/Everything/x86_64/ --repo=epel --download-metadata
    
### 2.3 create repodata

    createrepo /var/www/repos/rocky/epel/8/Everything/x86_64/

### 2.4 update from official repository

    reposync -p /var/www/repos/rocky/epel/8/Everything/x86_64/ --newest-only --repo=epel --download-metadata

### 2.5 update repodata

    createrepo --update /var/www/repos/rocky/epel/8/Everything/x86_64/

### 2.6 testing

    dnf list xrdp

## 3. dnf localinstall

### 3.1 create repodata

    dnf -y install yum-utils

### 3.2 make directory

    mkdir ~/packages

### 3.3 examples
    
    yumdownloader nfs-utils --downloadonly --resolve --downloaddir ~/packages/

### 3.4 example with remmina
    
    yumdownloader remmina --downloadonly --resolve --downloaddir ~/packages/remmina

### 3.5 install with remmina

    dnf localinstall avahi-ui-gtk3-0.7-20.el8.x86_64.rpm libappindicator-gtk3-12.10.0-19.el8.x86_64.rpm libdbusmenu-16.04.0-12.el8.x86_64.rpm libdbusmenu-gtk3-16.04.0-12.el8.x86_64.rpm libindicator-gtk3-12.10.1-14.el8.x86_64.rpm libsodium-1.0.18-2.el8.x86_64.rpm remmina-1.4.32-1.el8.x86_64.rpm remmina-plugins-exec-1.4.32-1.el8.x86_64.rpm remmina-plugins-rdp-1.4.32-1.el8.x86_64.rpm remmina-plugins-secret-1.4.32-1.el8.x86_64.rpm remmina-plugins-vnc-1.4.32-1.el8.x86_64.rpm

<hr/>

## 4. YUM for CentOS 7

    mkdir -p /var/www/repos/centos/7/os/x86_64/
    mkdir -p /var/www/repos/centos/7/updates/x86_64/
    mkdir -p /var/www/repos/centos/7/extras/x86_64/
    mkdir -p /var/www/repos/centos/7/centosplus/x86_64/
    chmod -R 755 /var/www/repos

    reposync -p /var/www/repos/centos/7/os/x86_64/ --repo=base --download-metadata
    reposync -p /var/www/repos/centos/7/updates/x86_64/ --repo=updates --download-metadata
    reposync -p /var/www/repos/centos/7/extras/x86_64/ --repo=extras --download-metadata
    reposync -p /var/www/repos/centos/7/centosplus/x86_64/ --repo=centosplus --download-metadata

    createrepo /var/www/repos/centos/7/os/x86_64/
    createrepo /var/www/repos/centos/7/updates/x86_64/
    createrepo /var/www/repos/centos/7/extras/x86_64/
    createrepo /var/www/repos/centos/7/centosplus/x86_64/

    reposync -p /var/www/repos/centos/7/os/x86_64/ --newest-only --repo=base --download-metadata
    reposync -p /var/www/repos/centos/7/updates/x86_64/ --newest-only --repo=updates --download-metadata
    reposync -p /var/www/repos/centos/7/extras/x86_64/ --newest-only --repo=extras --download-metadata
    reposync -p /var/www/repos/centos/7/centosplus/x86_64/ --newest-only --repo=centosplus --download-metadata

    createrepo --update /var/www/repos/centos/7/os/x86_64/
    createrepo --update /var/www/repos/centos/7/updates/x86_64/
    createrepo --update /var/www/repos/centos/7/extras/x86_64/
    createrepo --update /var/www/repos/centos/7/centosplus/x86_64/
    
    reposync -p /var/www/repos/ --repo=epel --download-metadata

    createrepo /var/www/repos/epel/

    reposync -p /var/www/repos/ --newest-only --repo=epel --download-metadata
    
    createrepo --update /var/www/repos/epel/
