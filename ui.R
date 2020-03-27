bootstrapPage(
  theme = 'world.css',
  tags$div(
    id = "op1",
    type = "button",
    class = "btn btn-default action-button",
    "World"
  ),
  conditionalPanel(
    "input.op1 == true",
    leafletOutput('map', height = '100vh'),
    div(class = 'country_name', div(id = 'text', class = 'shiny-text-output'))
  )



  # div(id = "op1", class = "btn btn-default action-button", "Europe"),
  # div(id = 'op2', class = "btn btn-default action-button", "Africa"),
  # div(id = 'op3', class = "btn btn-default action-button", "Asia"),
  # div(id = 'op4', class = "btn btn-default action-button", "America")
)