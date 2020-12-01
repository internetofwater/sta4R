#' Retrieve all locations from STA instance
#' @description Given an STA endpoint, will get all location entities and
#' collate them into an [`sf`](https://cran.r-project.org/web/packages/sf/) object.
#' It checks if the STA call has been paginated. If it is paginated, it retrieves
#' the total number of locations and the default $skip value, and iterates through,
#' retrieving all locations.
#' @param api character URL of an STA endpoint.
#' @return an sf object of every STA location entity.
#' @export
sta_getLocations <- function(api){
  call <- URLencode(paste0(api,"/Locations"))
  response <- jsonlite::fromJSON(URLencode(paste0(call,"?$count=true")))
  if (is.null(response$`@iot.nextLink`)){
    x <- sta_getLocationsCall(call)
  } else {
    x <- sta_iterate(call,response,sta_getLocationsCall)
  }
  return(x)
}

#' Parse a GET Locations request response from an STA instance
#' @description Given an STA/Locations call, including any query parameters,
#' will get all location entities collate into an
#' [`sf`](https://cran.r-project.org/web/packages/sf/) object.
#' A helper function for `sta_getLocations` as it iterates through a paginated
#' STA Location document.
#' @param call character URL of an STA Locations call, including any query parameters
#' @return an sf object of every STA location entity.
sta_getLocationsCall <- function(call){
  j <- rawToChar(httr::GET(call)$content)
  j <- gsub('\"coordinates\":\\[\\]','\"coordinates\":\\[0,0\\]',j)
  x <- rjson::fromJSON(j)$value
  x <- lapply(x,function(x){rjson::toJSON(x)})
  x <- do.call(dplyr::bind_rows,lapply(x,function(x){geojsonio::geojson_sf(x)}))
  j <- jsonlite::fromJSON(j)$val
  j$location <- NULL
  j <- sf::st_as_sf(cbind(j,x))
  return(j)
}
