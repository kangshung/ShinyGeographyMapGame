if(!require('pacman')) install.packages('pacman')
pacman::p_load(shiny, leaflet, sf)

ui <- bootstrapPage(theme = 'css.css',
  leafletOutput('map', height = '100vh'),
  div(class = 'country_name', div(id = 'text', class = 'shiny-text-output'))
)

server <- function(input, output, session) {
  select_sf <- reactive({
    read_sf('ne_50m_admin_0_countries')
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