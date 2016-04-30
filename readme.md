---
author: "organofcorti"
date: "30 April 2016"
---

This R script scrapes and flattens blockchain variable data from blockchain.info into a data.table. Use Sys.sleep() command if you need to slow down your request due to the request limiter, currently set to:

* Requests in 8 Hours: 3 (Soft Limit = 30000, Hard Limit = 30500) 
* Requests in 5 minutes: 3 (Soft Limit = 500, Hard Limit = 525) 

Check https://blockchain.info/api for up-to-date info, and https://blockchain.info/api/api_create_code if you want to avoid the request limiter altogether.


