
#### set path
setwd("/your/path/here")

#### set your repo
#R_repo <- "http://cran.csiro.au/"
R_repo <- "http://your/R/repo/"

libs <- list("RJSONIO", "data.table", "pbapply", "plyr")

invisible(lapply(libs, function(x){
        result <- library(x, logical.return=T, character.only =T)
        if(result == F) install.packages(x, repos=R_repo)
        library(x, character.only =T)
}))


bci_url1 <- "https://blockchain.info/block-height/"
bci_url2 <- "?format=json"


### example of an orphan at 409327
### we need to flatten the lists in order
### to just have the data you want - coinbase tx, 
### generation address, timestamp, etc

flatten_list_func <- function(x){
        data_list_0 <- fromJSON(paste0(bci_url1, x, bci_url2))
        data_list_1 <- llply(data_list_0$blocks, function(x) llply(x, function(y) y[[1]]))
        data_table_0 <- data.table(ldply(data_list_1, function(x) data.frame(x)))
 
        # if no tx.addr tag, add a dummy var to keep table flat
        if(!any(colnames(data_table_0) == "tx.out.addr_tag")) {
                data_table_0[, tx.out.addr_tag := "Unknown"]
        }
               
        # ignore orphans, keep data you want
        data_table_1 <- data_table_0[main_chain==TRUE, list(time, height, hash, ver, fee,  n_tx, 
        size , script_hex = tx.inputs.script, tx.hash,  tx.out.addr, tx.out.addr_tag)]

        #### script_hex can be converted to ASCII for coinbase signature
        
        #### Sys.sleep() command if you need to slow down your requests 
        #### due to the request limiter
        
        # Sys.sleep(5)
        
        return(data_table_1)
        
}

blocks_requested <- 409321:409331

blockchain_dt <- rbindlist(pbsapply(blocks_requested, flatten_list_func, simplify=F))

write.csv(blockchain_dt, "blockchain_info.csv")

