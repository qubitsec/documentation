## 1. Solr

### 1.1 Run

    ~/solr/bin/solr start -cloud

    ~/solr/bin/solr stop

## 2. Solr

### 2.1 Add-field-type

```
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "10.100.10.175"
gitlab_rails['smtp_port'] = 25
gitlab_rails['smtp_user_name'] = "eliot"
gitlab_rails['smtp_password'] = "qwerty1357!"
gitlab_rails['smtp_domain'] = "plura.kr"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
gitlab_rails['smtp_pool'] = false
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
