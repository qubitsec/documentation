# nfs


## 1. Install

### 1.1 Install

    dnf -y install nfs-utils


### 1.2 Make directory

    mkdir -p /home/nfsshare

### 1.3 Config

    vi /etc/idmapd.conf
    
    Domain = qubitsec.com

    vi /etc/exports

    /home/nfsshare 10.10.10.0/23(rw,no_root_squash)

    systemctl enable --now rpcbind nfs-server

## 2. Firewall

### 2.1 Config

    firewall-cmd --add-service=nfs
    
    firewall-cmd --add-service={nfs3,mountd,rpc-bind}
        
    firewall-cmd --runtime-to-permanent
    
## 3. Useful Links

    https://www.server-world.info/en/note?os=Rocky_Linux_8&p=nfs&f=1


## 4. Example for nfs client config

![nfs_vmware](https://github.com/QubitSecurity/documentation/assets/24949168/06f2608a-bbc0-4dd0-8257-db4a87847fe5)
