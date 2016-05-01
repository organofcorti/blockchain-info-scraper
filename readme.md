---
author: "organofcorti"
date: "30 April 2016"
---

This [R](http://r-project.org) script scrapes and flattens blockchain variable data from blockchain.info into a data.table. 


##### Before running script:
Make sure you enter your working directory:  
```R
setwd("/your/path/here")
```  
and preferred R repo:  
```R
R_repo <- "http://your/R/repo/"
```
  
##### The output table will contain fields for the following variables:
"time", "height", "hash", "ver", "fee", "n_tx", "size","script_hex", "tx.hash", "tx.out.addr", "tx.out.addr_tag"
Mining pools and other block makers can be identified using the generation address ("tx.out.addr") or converting "script_hex" to a coinbase signature. "tx.out.addr_tag" is blockchain.info's guess at the block maker based on a list of known generation addresses.  

An example of the output is here: [blockchain_info.csv](https://github.com/organofcorti/blockchain-info-scraper/blob/master/blockchain_info.csv)


##### Use Sys.sleep() command if you need to slow down your request due to the request limiter, currently set to:
   * Requests in 8 Hours: 3 (Soft Limit = 30000, Hard Limit = 30500) 
   * Requests in 5 minutes: 3 (Soft Limit = 500, Hard Limit = 525) 

  
##### Check https://blockchain.info/api for up-to-date info, and https://blockchain.info/api/api_create_code if you want to avoid the request limiter altogether.


