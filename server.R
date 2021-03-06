function(input, output, session) {
  output$map <- renderLeaflet({
    leaflet(st_transform(world, 4326),
            options = leafletOptions(2, 5, crs = leafletCRS("L.CRS.EPSG4326"))) %>%
      setView(0, 50, zoom = 4) %>%
      addPolygons(
        fillColor = 'gray',
        color = 'black',
        weight = .1,
        highlightOptions = highlightOptions(weight = 2),
        layerId = ~ NAME_EN
      )
  })

  output$text <- renderText('Click a country')

  observeEvent(input$map_shape_click, {
    output$text <- renderText({
      input$map_shape_click$id
    })
  })
}