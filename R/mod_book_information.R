#' book_information UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom DT dataTableOutput
mod_book_information_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::sidebarLayout(
      shiny::sidebarPanel(width = 3,
                          h3("Help"),
                          shiny::textOutput(ns("note")),
                          br(),
                          shiny::textOutput(ns("help"))
                          
      ),
      
      mainPanel(width = 9,
                fluidRow(
                  column(4, shiny::numericInput(ns("min_rating"),
                                                "Minimum Average Rating",
                                                value = 3.5, min = 0, max = 5,
                                                step = 0.1)),
                  column(4, shiny::numericInput(ns("max_pages"),
                                                "Maximum Number of Pages",
                                                value = 500, min = 1,
                                                max = 1000)),
                  column(4, shiny::dateRangeInput(ns("dates"),
                                                  "Publication Date",
                                                  start = as.Date("1990-01-01"),
                                                  end = as.Date("2020-09-30"),
                                                  min = min(books_data$publication_date,
                                                            na.rm = TRUE),
                                                  max = Sys.Date()))
                ),
                
                shiny::textOutput(ns("average_read")),
                DT::dataTableOutput(ns("table"))
      )
    )
    
  )
}

#' book_information Server Function
#'
#' @noRd
#' @importFrom zeallot %<-% 
#' @importFrom DT renderDataTable datatable
mod_book_information_server <- function(input, output, session){
  ns <- session$ns
  
  output$note <- renderText({
    return("Note that the data is based on GoodReads information, and has not been altered in any way.")
  })
  
  output$table <- DT::renderDataTable({
    data <- filter_data(input$min_rating, input$max_pages, input$dates[1], input$dates[2])
    DT::datatable(data)
  })
  
  output$average_read <- renderText({
    data <- filter_data(input$min_rating, input$max_pages, input$dates[1], input$dates[2])
    c(top, average) %<-% average_pages_read(data)
    glue::glue("If you read the {top} top-rated books below in the remaining year, then your average pages read per day would be {average} pages.")
  })
  
  output$help <- renderText({
    glue::glue("
    This application was designed for book enthusiasts in order to help them find their next book to read based on popular, highly-rated books.
    
    You have at your disposal various selection criteria which filters for a list of books that fits your requirements.
               
    You can specify a minimum average rating, the maximum number of pages in a book that you are prepared to read, and (if you desire) a range of publication dates, in the event that you prefer most recently published books.
               
    As an added feature, an indication of the average pages read per day is given based on an assumption of reading a book a week for the remaining year and assuming you read the top-rated books from the filtered list.
               ")

  })
  
}

## To be copied in the UI
# mod_book_information_ui("book_information_ui_1")

## To be copied in the server
# callModule(mod_book_information_server, "book_information_ui_1")

