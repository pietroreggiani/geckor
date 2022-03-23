#' Get historical data for panel of coins
#'
#' @param maxcoins Limit the query to the first 'maxcoins' in the coin_ids list. To get the full list of coins, run `geckor::supported_coins()`  
#' @param coin_ids the list or vector containing the id's of the coins. This comes from using `geckor::supported_coins()`.
#' @param ... additional parameters to be passed to `geckor::coin_history()`
#'
#' @return a data table with a panel of coins at daily or more granular frequency. For details, see `geckor::coin_history()`.
#' 
#'
#' @examples
get_history_panel <- function(maxcoins, coin_ids, ...){
  
  require(geckor)
  require(data.table)
  
  coinsdata = data.table()
  calls_done = 0
  
  for (coin.num in 1:maxcoins){
    
    coin_id = coin_ids[[coin.num]] 
    
    coin_data = geckor::coin_history(coin_id = coin_id, ...  ) 
    
    coinsdata = rbindlist( list(coinsdata, coin_data) , use.names = TRUE  )
    
    calls_done = calls_done + 1
    
    message("We have done ", calls_done , " calls.")
    
  }
  
  return(coinsdata)
  
}
