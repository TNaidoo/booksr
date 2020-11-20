
#' Filter Book Data
#' 
#' Filters book data for a minimum rating, maximum number of pages,
#'     and publication date.
#'
#' @param min_rating Minimum average rating.
#' @param max_pages Maximum number of pages.
#' @param min_publish_date Minimum publication date.
#' @param max_publish_date Maximum publication date.
#'
#' @return Filtered set of data.
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#' @export
#'
#' @examples
#' data <- filter_data(4, 200, as.Date("2020-01-01"), as.Date("2020-09-30"))
filter_data <- function(min_rating, max_pages, min_publish_date, max_publish_date) {
  out_data <- books_data %>%
    dplyr::filter(average_rating >= min_rating,
                  num_pages <= max_pages,
                  publication_date >= min_publish_date,
                  publication_date <= max_publish_date) %>%
    subset(select = c("title", "authors", "average_rating", "num_pages", "publication_date", "publisher")) %>%
    dplyr::arrange(desc(average_rating))
  colnames(out_data) <- c("Title", "Author", "AverageRating", "NumberOfPages", "PublicationDate", "Publisher")
  return(out_data)
}

#' Average Pages Calculation
#' 
#' Calculates the average pages read per day if a person reads the top listed books from the dataset.
#'     The number of books is based on a calculation of 1 book a week for the remaining year.
#'
#' @param data Dataset of filtered books.
#'
#' @return Average number of pages per day over the remaining year.
#' @importFrom lubridate ceiling_date
#' @importFrom zeallot %<-%
#' @export
#'
#' @examples
#' average_pages_read(data.frame(NumberOfPages = c(25, 168, 150, 210)))
average_pages_read <- function(data) {
  current_date <- Sys.Date()
  end_of_year <- lubridate::ceiling_date(current_date, "year")-1
  num_of_days <- as.numeric(end_of_year - current_date) + 1
  top_number <- round(num_of_days/7)
  total_pages <- sum(data$NumberOfPages[1:top_number], na.rm = TRUE)
  average_pages <- round(total_pages/num_of_days)
  return(list(top_number, average_pages))
}