## 1. Solr

### 1.1 Run and Stop

    ~/solr/bin/solr start -cloud

    ~/solr/bin/solr stop

## 2. Directory mount

### 2.1 

    ~/solr/bin/solr start -cloud

    ~/solr/bin/solr stop

### 2.2 Make NFS Disk Mount

    mkdir solrbackup

    sudo mount -t nfs 10.100.61.144:/home/nfsshare/109 /home/sysadmin/solrbackup

    sudo chown username.username solrbackup/

### 2.3 Index copy from nfs mount to local

    rsync -av /home/sysadmin/solrbackup/ /home/username/solr-data/weblog_shard1_replica_n482/data

## 3. Umount

### 3.1 Add-field-type

### 2.3 Index copy from nfs mount to local

    rsync -av /home/sysadmin/solrbackup/ /home/username/solr-data/weblog_shard1_replica_n482/data

## 3. Check

### 3.1 Count files

    ls -l /home/nfsshare/97/index.20240118143136254/ | wc -l

## 4. unmount

### 4.1 Count files

    sudo reboot

    sudo umount /home/username/solrbackup/

    rm -rf solrbackup/

    sudo systemctl stop rpcbind


### 4.1 Count files

```
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field-type": {
    "name": "keyword_analysis",
    "class": "solr.TextField",
    "positionIncrementGap": "100",
    "indexAnalyzer": {
      "tokenizer": {
        "class": "solr.KeywordTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        },
        {
          "class": "solr.EdgeNGramFilterFactory",
          "maxGramSize": "32",
          "minGramSize": "2"
        }
      ]
    },
    "queryAnalyzer": {
      "tokenizer": {
        "class": "solr.KeywordTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        }
      ]
    }
  }
}' http://localhost:8983/solr/syslog/schema
```
<hr/>
### 2.2 Replace-field

```
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "replace-field":{
     "name":"logMessage",
     "type":"keyword_analysis",
     "multiValued":false,
     "indexed":true,
     "required":false,
     "stored":true}
}' http://localhost:8983/solr/syslog/schema
```

<hr/>

```
{
  "replace-field-type": {
    "name": "msg_analysis",
    "class": "solr.TextField",
    "positionIncrementGap": "100",
    "indexAnalyzer": {
      "charFilters": [
          {
            "class": "solr.PatternReplaceCharFilterFactory",
            "pattern": "\"",
            "replacement": ""
          },
          {
            "class": "solr.PatternReplaceCharFilterFactory",
            "pattern": "'",
            "replacement": ""
          },
          {
            "class": "solr.PatternReplaceCharFilterFactory",
            "pattern": "msg=audit\\([^)]+\\):",
            "replacement": ""
          },
          {
            "class": "solr.PatternReplaceCharFilterFactory",
            "pattern": "msg=",
            "replacement": ""
          }
      ],
      "tokenizer": {
        "class": "solr.StandardTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        },
        {
          "class": "solr.EdgeNGramFilterFactory",
          "maxGramSize": "20",
          "minGramSize": "2"
        },
        {
          "class": "solr.StopFilterFactory",
          "ignoreCase": "true",
          "words": "stopwords.txt"
        },
        {
          "class": "solr.SynonymGraphFilterFactory",
          "synonyms": "synonyms.txt",
          "ignoreCase": "true",
          "expand": "true"
        }
      ]
    },
    "queryAnalyzer": {
      "tokenizer": {
        "class": "solr.KeywordTokenizerFactory"
      },
      "filters": [
        {
          "class": "solr.LowerCaseFilterFactory"
        },
        {
          "class": "solr.SynonymGraphFilterFactory",
          "synonyms": "synonyms.txt",
          "ignoreCase": "true",
          "expand": "true"
        }
      ]
    }
  }
}
```

<hr/>

```
curl -X POST -H "Content-type: application/json" --data-binary @schema_syslog_msg.json http://localhost:8983/solr/syslog/schema
```

<hr/>

```
c
```

<hr/>

```
d
```
