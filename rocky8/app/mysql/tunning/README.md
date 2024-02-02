

### 1.1 Check Database size

```
SELECT table_schema AS `Database`, 
SUM(data_length + index_length) / 1024 / 1024 AS `Size in MB` 
FROM information_schema.TABLES 
GROUP BY table_schema;
```
<hr/>
### 2.2 Replace-field
