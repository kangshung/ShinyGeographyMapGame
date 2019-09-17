if(!require('pacman')) install.packages('pacman')
# pacman::p_load(shiny, leaflet, sf, jsonlite)
library(shiny); library(leaflet); library(sf); library(jsonlite)

continents <- fromJSON('https://pkgstore.datahub.io/JohnSnowLabs/country-and-continent-codes-list/country-and-continent-codes-list-csv_json/data/c218eebbf2f8545f3db9051ac893d69c/country-and-continent-codes-list-csv_json.json')
dplyr::left_join(read_sf('ne_10m_admin_0_countries'), continents, c(''))

ui <- bootstrapPage(theme = 'css.css',
  leafletOutput('map', height = '100vh'),
  div(class = 'country_name', div(id = 'text', class = 'shiny-text-output'))
)

server <- function(input, output, session) {
  select_sf <- reactive({
    read_sf('ne_10m_admin_0_countries')
  })
  
  output$map <- renderLeaflet({
    leaflet(select_sf(), options = leafletOptions(2, 5)) %>% 
      setView(0, 50, zoom = 2) %>% 
      addPolygons(color = 'gray', weight = .1, highlightOptions = highlightOptions(weight = 2), layerId = ~FORMAL_EN)
  })
  
  output$text <- renderText('Click a country')
  
  observeEvent(input$map_shape_click, {
    output$text <- renderText({
      input$map_shape_click$id
    })
  })
}

shinyApp(ui, server)