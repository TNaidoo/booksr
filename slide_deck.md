Books
========================================================
author: Thrish Naidoo
date: 2020-11-20
autosize: true

Introduction
========================================================

This application was designed for book enthusiasts in order to help them find their next book to read based on popular, highly-rated books.

- Users can input
  * a minimum rating for books they are searching for.
  * the maximum number of pages for the books.
  * publication date (in the event they are searching for recently published books).
- As an added feature, an indication of the average pages read per day is given based on an assumption of reading a book a week for the remaining year and assuming the person reads the top rated books from the filtered list.

User Interface
========================================================

<img src="interface.png">

Calculation of Average Pages per Day
========================================================


```r
source("./data-raw/books_data.R")
source("./R/fct_helpers.R")
library(zeallot)
library(glue)
data <- filter_data(3.5, 500, as.Date("1990-01-01"), as.Date("2020-09-30"))
c(top, average) %<-% average_pages_read(data)
glue::glue("If you read the {top} top-rated books below in the remaining year, then your average pages read per day would be {average} pages.")
```

```
If you read the 6 top-rated books below in the remaining year, then your average pages read per day would be 37 pages.
```

References
========================================================
- Book data was sourced from <https://www.kaggle.com/jealousleopard/goodreadsbooks>.
