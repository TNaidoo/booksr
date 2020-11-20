## code to prepare `books_data` dataset goes here

library(dplyr)
books_data <- utils::read.csv("books.csv", header = TRUE) %>%
  dplyr::mutate(average_rating = as.numeric(as.character(average_rating)),
                num_pages = as.numeric(num_pages),
                ratings_count = as.numeric(ratings_count),
                text_reviews_count = as.numeric(text_reviews_count),
                publication_date = as.Date(publication_date, tryFormats = c("%m/%d/%Y")))
usethis::use_data(books_data, overwrite = TRUE)
