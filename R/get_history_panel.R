#' Get historical data for panel of coins
#'
#' @param maxcoins Limit the query to the first 'maxcoins' in the coin_ids list. To get the full list of coins, run `geckor::supported_coins()`
#' @param coin_ids the list or vector containing the id's of the coins. This comes from using `geckor::supported_coins()`.
#' @param ... additional parameters to be passed to `geckor::coin_history()`
#'
#' @return a data table with a panel of coins at daily or more granular frequency. For details, see `geckor::coin_history()`.
#' @export
#'
#' @examples
get_history_panel <- function(coin_ids , ...){


  coinsdata = data.table::data.table()
  calls_done = 0

  maxcoins = length(coin_ids)

  for (coin.num in 1:maxcoins){

    coin_id = coin_ids[[coin.num]]

    coin_data = try( geckor::coin_history(coin_id = coin_id, ...  ) )

    # if the query gave an error and stopped, the try will return an error
    # in that case stop the function and return wathever was queried so far.

    if (  class(coin_data)  == "try-error"  ){
      message("The API call encountered a problem. The code is halted.")
      return(coinsdata)

    } else {

      coinsdata = data.table::rbindlist( list(coinsdata, coin_data) , use.names = TRUE  )

      calls_done = calls_done + 1

      message("We have done ", calls_done , " calls.")

    }



  }

  return(coinsdata)

}
