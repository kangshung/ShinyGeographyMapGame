if(!require('pacman')) install.packages('pacman')
# pacman::p_load(shiny, leaflet, sf, jsonlite)
library(shiny); library(leaflet); library(sf); library(R6); library(data.table); library(lwgeom)

world <- setDT(st_read('ne_50m_admin_0'))

map <- R6Class('map',
  private = list(
    option = NULL
  ),
  public = list(
    sample = function() {
      sample(world$NAME_EN)
    }
  )
)


leaflet(st_as_sf(world), options = leafletOptions(crs = leafletCRS(proj4def = '+proj=wintri'))) %>% addPolygons()

ui <- bootstrapPage(theme = 'css.css',
  leafletOutput('map', height = '100vh'),
  div(class = 'country_name', div(id = 'text', class = 'shiny-text-output'))
)

server <- function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(st_as_sf(world[CONTINENT == 'Europe']), options = leafletOptions(2, 5)) %>% 
      setView(0, 50, zoom = 2) %>% 
      addPolygons(fillColor = 'gray', color = 'black', weight = .1,
                  highlightOptions = highlightOptions(weight = 2),
                  layerId = ~NAME_EN)
  })
  
  output$text <- renderText('Click a country')
  
  observeEvent(input$map_shape_click, {
    output$text <- renderText({
      input$map_shape_click$id
    })
  })
}

shinyApp(ui, server)