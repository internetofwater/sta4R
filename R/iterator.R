#' Iterator
#' @description Given an STA call, response document,
#' and parsing function, will detect the total entity count
#' and default $skip value. It will use these values to
#' iterate through the paginated response document, and
#' collate together the resulting responses according
#' to the passed function
#' @param call character URL of STA call.
#' @param resonse json document corresponding to the
#' `call`
#' @param fun any function that parses STA responses
#' into R data structures that can be row-binded.
#' An example is `sta_getLocationsCall()`
#' @return a collation of objects created by `fun`
sta_iterate <- function(call,response,fun){
  skip <- strsplit(response$`@iot.nextLink`,"skip=")[[1]][2]
  skip <- as.numeric(strsplit(skip,split="&")[[1]][1])
  count <- response$`@iot.count`
  k <- floor(count/skip)
  list <- paste0(call,"?$skip=",0:k*skip)
  x<-purrr::map(list,fun)
  x <- do.call(dplyr::bind_rows,x)
  return(x)
}
