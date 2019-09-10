if(!require('pacman')) install.packages('pacman')
pacman::p_load(shiny, leaflet)

ui <- fluidPage(
  leafletOutput('map')
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles()
  })
}

shinyApp(ui, server)