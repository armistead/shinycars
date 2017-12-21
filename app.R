
## Shiny Cars and Apps

## first things first get your packages
library(shiny)
library(tidyverse)

data <- as.tibble(mpg)

carclass <- unique(mpg$class)

ui <- fluidPage(
        titlePanel("Fuel efficiency and Car Size"), ##always need a simple title.
        sidebarLayout( ##this applies to the entire webpage, so make sure you include MainPanel below inside the parentheses.
                sidebarPanel( ##here we set the input area
                        checkboxGroupInput("group", "Class", ##based on type of car.
                                           choices=carclass, selected = carclass)
                        ),
                mainPanel(
                        plotOutput("plot") ##send the plot to the main section of the webpage.
                ))
)

server <- function(input, output) { ##inputs set above and outputs set below
        output$plot <- renderPlot({
                filtered <- data %>%
                        filter(data$class %in% input$group
                        )
                ggplot(filtered, aes(displ, hwy)) +
                        geom_point(aes(color = class)) + ##in case the user selects multiple car types, we want to color each one differently.
                        geom_smooth(se = FALSE) + ##add a smoothing line for reference
                        labs(
                                title = "Fuel efficiency falls as engine size rises",
                                subtitle = "With the mpg dataset, the tidyverse, and Shiny packages, I can create the plot below",
                                caption = "Data from fueleconomy.gov. Thanks to Hadley Wickham and RStudio for the template."

                        )
        })
}
shinyApp(ui = ui, server = server)