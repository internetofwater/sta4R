#' Map locations of SensorThings API Locations entities
#' @description Given a STA endpoint, creates a `mapview` html map
#' of the endpoints and any links provided by STA.
#' @param api a character URL for an STA endpoint
#' @param ... any arguments for `mapview`
#' @return `mapview` plot
#' @export
sta_mapview <- function(api, ...){
  mapview::mapview(convert_links(sta_getLocations(api)), ...)
}

#' Convert links
#' @description Given a data.frame/ tibble, converts any
#'  texts in a data frame/ tibble that begin with "httr" to
#' a hyperlink
#' @param x a data.frame or tibble
#' @return the same data frame with any http text converted to hyperlink html.
convert_links <- function(x) {
  for(n in names(x)) {
    if(is.character(x[[n]])) {
      test <- grepl("^http", x[[n]])
      x[[n]][test] <- paste0('<a href="',
                             x[[n]][test],
                             '" target="_blank">',
                             x[[n]][test],
                             '</a>')
    }
  }
  x
}
