fontSize=10
localStyle=paste0("font-size:",format(fontSize) ,"pt;text-align: right;padding:0px;margin:0px;margin-right:5px;")
colourChoices=list("black","white","red","green","blue","yellow")

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML( # labels 
      paste0(".label {font-size: ",fontSize ,"; font-weight:bold;text-align: right;margin:0px;padding:0px;}")
    )),
    tags$style(HTML( # textInput
      paste0(".form-control {font-size: ",fontSize ,"; height:24px; padding:0px 0px;margin:0px;}")
    )),
    tags$style(HTML( # selectInput
      paste0(".selectize-input {font-size: ",fontSize ,"; height:12px; width:60px; padding:0px; margin-right:-10px; margin-top:-5px;margin-bottom:-5px; min-height:10px;}"),
      paste0(".selectize-dropdown { font-size: ",fontSize ,";line-height:10px}")
    )),
    tags$style(HTML( # action button
      paste0(".col-sm-3 button {font-size:",fontSize ,";font-weight:Bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}"),
      paste0( ".col-sm-2 button {font-size:",fontSize ,";font-weight:Bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}"),
      paste0(".col-sm-1 button {font-size:",fontSize ,";font-weight:Bold;color:white; background-color: #005886;height:20px;padding-top:0px;padding-bottom:0px;padding-left:4px;padding-right:4px;margin-bottom:4px;margin-right:12px;margin-top:4px;margin-left:0px}")
    )),
    tags$style(HTML( # well panels
      ".well {padding:5px; margin:0px;margin-bottom:8px;margin-left:0px;margin-right:0px;} "
    )),
    tags$style(HTML( # checkbox
      ".checkbox {line-height: 10px;margin:0px;padding:0px;padding-left:4px;}"
    ))
  ),
  tags$head( # alignment of controls  
    tags$style(type="text/css",".table label{ display: table-cell; text-align: center;vertical-align: middle; }  .form-group { display: table-row;}")
  ),
  tags$head( # alignment of controls
    tags$style(".myTable {margin:0px;padding:0px;}")
  ),
  
  # App title ----
  titlePanel("Autism"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      style = paste("background: ",'#aaa',';width:200px;height:480px',";margin-left: 0px;margin-right: -21px;margin-top: 12px;padding-right: -21px;border-radius:0px;"),
      # Input: 
      verticalLayout(
        wellPanel(h4("Personality Factors"),
                  tags$table(width="100%",class="MyTable",
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"autism (0-1):")),
                               tags$td(width = "30%", numericInput("autismExponent", NULL, min = 0, max = 1, step = 0.1, value = 0.25))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"sensitivity (0.1-2):")),
                               tags$td(width = "30%", numericInput("autismSD", NULL, min = 0.1, max = 2, step = 0.1, value = 1))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"capacity (5-100%):")),
                               tags$td(width = "30%", numericInput("autismCapacity", NULL, min = 5, max = 100, step = 5, value = 50))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"bias (0-1):")),
                               tags$td(width = "30%", numericInput("autismBias", NULL, min = 0, max = 1, step = 0.1, value = 0.25))
                             )
                  )
        ),
        # wellPanel(h4("Measures"),
        #           tags$table(width="100%",
        #                      tags$tr(
        #                        tags$td(width = "50%", tags$div(style=localStyle,"no measures:")),
        #                        tags$td(width = "50%", numericInput("nsegments", NULL, min = 4, max = 49, step = 5, value = 39))
        #                      )
        #           )
        # ),
        actionButton(inputId = "New", label = "New" )
      ),
      width=3
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      style = paste("background: ",'#fff',';','width:500px;height:500px;',"margin: 0px;padding: 0px;border-radius:0px;"),
      
      # Output: 
      htmlOutput(outputId = "spectrumHTML",width="250px",height="250px"),
      htmlOutput(outputId = "autismHTML",width="450px",height="250px"),
      plotOutput(outputId = "spectrumPlot",width="250px",height="250px"),
      plotOutput(outputId = "autismPlot",width="450px",height="250px"),
      width=9
      
    )
  )
)