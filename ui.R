bootstrapPage(theme = 'world.css',
              leafletOutput('map', height = '100vh'),
              div(class = 'country_name', div(id = 'text', class = 'shiny-text-output')))