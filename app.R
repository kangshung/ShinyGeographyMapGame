if(!require('pacman')) install.packages('pacman')
pacman::p_load(shiny, leaflet, sf)

ui <- fluidPage(
  sidebarPanel(width = 6,
               selectInput('sf', 'Choose shapefile', 'WORLD')),
  conditionalPanel('input.sf == "WORLD"',
                   leafletOutput('map'),
                   textOutput('sample'))
)

server <- function(input, output, session) {
  select_sf <- reactive({
    if(input$sf == 'WORLD') read_sf('ne_50m_admin_0_countries')
  })
  
  sample_country <- reactive({
    sample(select_sf()$ADMIN, 1)
  })
  
  output$sample <- reactive({
    sample_country()
  })
  
  output$map <- renderLeaflet({
    leaflet(select_sf()) %>% 
      addPolygons(color = 'gray', weight = .1, highlightOptions = highlightOptions(weight = 2))
  })
}

shinyApp(ui, server)