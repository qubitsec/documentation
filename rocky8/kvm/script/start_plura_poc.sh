#!/usr/bin/env bash

virsh start 010014-plc
virsh start 010015-plc

virsh start 010021-haproxy
virsh start 010022-haproxy
virsh start 010024-haproxy
virsh start 010025-haproxy
virsh start 010027-haproxy
virsh start 010028-haproxy

virsh start 010040-cloudsupport
virsh start 010041-cloudsupport

virsh start 010042-purplecow
virsh start 010043-purplecow

virsh start 010044-iapis-event
virsh start 010045-iapis-event

virsh start 010046-iapis-nfs
virsh start 010047-iapis-nfs

virsh start 010050-redis
virsh start 010051-redis
virsh start 010052-redis

virsh start 010056-front
virsh start 010057-front

virsh start 010060-iapis-type1
virsh start 010061-iapis-type1
virsh start 010062-iapis-type1
virsh start 010063-iapis-type1

virsh start 010076-apis-public
virsh start 010077-apis-public

virsh start 010080-iapis-type2
virsh start 010081-iapis-type2
virsh start 010082-iapis-type2
virsh start 010083-iapis-type2

virsh start 010100-iapis-solr
virsh start 010101-iapis-solr

virsh start 010116-sinker-all
virsh start 010117-sinker-all

virsh start 010118-sinker-r
virsh start 010119-sinker-r

virsh start 010120-analysis-main
virsh start 010121-analysis-main
virsh start 010122-analysis-main
virsh start 010123-analysis-main

virsh start 010134-analysis-r
virsh start 010135-analysis-r

virsh start 010128-analysis-apis
virsh start 010129-analysis-apis

virsh start 010140-analysis-filtermodsec
virsh start 010141-analysis-filtermodsec
virsh start 010142-analysis-filtermodsec
virsh start 010143-analysis-filtermodsec
virsh start 010144-analysis-filtermodsec
virsh start 010145-analysis-filtermodsec
virsh start 010146-analysis-filtermodsec
virsh start 010147-analysis-filtermodsec
virsh start 010148-analysis-filtermodsec
virsh start 010149-analysis-filtermodsec

virsh start 010200-kafka-web
virsh start 010201-kafka-web
virsh start 010210-kafka-sys
virsh start 010211-kafka-sys

virsh start 010215-kafka-sys-r

virsh start 010220-upload-all
virsh start 010221-upload-all

virsh start 010236-zk
virsh start 010237-zk
virsh start 010238-zk
virsh start 010239-zk

virsh start 010240-mysql
virsh start 010241-mysql
virsh start 010242-mysql
virsh start 010243-mysql
virsh start 010244-mysql
virsh start 010245-mysql
virsh start 010246-mysql
              
virsh start 010250-ansible
                
virsh start 010251-solr-nfs
