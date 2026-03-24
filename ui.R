fontSize=10
localStyle=paste0("font-size:",format(fontSize) ,"pt;text-align: right;padding:0px;margin:0px;margin-right:5px;")
refStyle=paste0("margin-left:20px;")
refrefStyle=paste0("margin-left:40px;")
colourChoices=list("black","white","red","green","blue","yellow")

ui <- fluidPage(
  
  tags$head(
    tags$style(HTML( # labels 
      paste0(".label {font-size: ",fontSize ,"; font-weight:bold;text-align: right;margin:0px;padding:0px;}")
    )),
    tags$style(HTML( # textInput
      paste0(".form-control {font-size: ",fontSize ,"; height:24px; padding:0px 0px;margin:0px;text-align: right;}")
    )),
    tags$style(HTML( # selectInput
      paste0(".selectize-input {font-size: ",fontSize ,"; height:12px; width:60px; padding:0px; margin-right:-10px; margin-top:-5px;margin-bottom:-5px; min-height:10px;}"),
      paste0(".selectize-dropdown { font-size: ",fontSize ,";line-height:10px}")
    )),
    tags$style(HTML( # action button
      paste0(".col-sm-3 button {font-size:",fontSize , ";font-weight:Bold;color:white; background-color: #005886;height:24px;padding:0px;padding-left:10px;padding-right:10px;margin:0px;}")
    )),
    tags$style(HTML( # well panels
      ".well {padding:2px; margin:0px;margin-bottom:8px;margin-left:0px;margin-right:0px;background-color: #eeeeee;border-radius:0} "
    )),
    tags$style(HTML( # checkbox
      ".checkbox {line-height: 10px;margin:0px;padding:0px;padding-left:4px;}"
    )),
    tags$style(HTML(
      ".table label{ display: table-cell; text-align: center;vertical-align: middle; }  .form-group { display: table-row;}"
      )),
    
    tags$style(HTML('.popup {
      position: relative;
      display: inline-block;
      cursor: pointer;
    }
      .popup .popuptext {
        visibility: hidden;
        width: 160px;
        background-color: #555;
          color: #fff;
          text-align: center;
        border-radius: 6px;
        padding: 8px 0;
        position: absolute;
        z-index: 1;
        bottom: 125%;
        left: 50%;
        margin-left: -80px;
      }
      .popup .popuptext::after {
        content: "";
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: #555 transparent transparent transparent;
      }
      .popup .show {
        visibility: visible;
      }',
                    '<script>
// When the user clicks on <div>, open the popup
function myFunction() {
  var popup = document.getElementById("myPopup");
  popup.classList.toggle("show");
}
</script>'
    ))
  ),

  # App title ----
  # titlePanel("Modelling Autism?"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      style = paste("background: ",'#fff',';width:240px;height:350px',";margin-left: 0px;margin-right: -21px;margin-top: 10px;padding-right: -21px;border-color:#fff;border-radius:0px;"),
      # Input: 
      verticalLayout(
        wellPanel(tags$div(style="margin-top:0px;font-weight:bold;","General traits"),
                  tags$table(width="100%",class="MyTable",
                             tags$tr(tags$td(width = "70%",
                                             tags$div(style=paste0(localStyle,"font-weight:bold;text-align: left;"),HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Capacity">Cognitive</a>'))) ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,'capacity (5-100%):')),
                               tags$td(width = "30%", numericInput("generalCapacity", NULL, min = 5, max = 100, step = 5, value = 50))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"sensitivity (0-1):")),
                               tags$td(width = "30%", numericInput("autismSensitivity", NULL, min = 0, max = 1, step = 0.1, value = 0))
                             )
                  )
        ),
        wellPanel(tags$div(style="margin-top:0px;font-weight:bold;","Autism-specific traits"),
                  tags$table(width="100%",class="MyTable",
                             tags$tr(tags$td(width = "70%",
                                             tags$div(style=paste0(localStyle,"font-weight:bold;text-align: left;"),HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Autism">Input demand</a>'))) ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,HTML('demand score (0-1):'))),
                               tags$td(width = "30%", numericInput("autismExponent", NULL, min = 0, max = 1, step = 0.1, value = 0.6))
                             ),
                             tags$tr(tags$td(width = "70%",
                                             tags$div(style=paste0(localStyle,"font-weight:bold;text-align: left;"),HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Masking">Masking</a>'))) ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"amount (0-1):")),
                               tags$td(width = "30%", numericInput("autismMask", NULL, min = 0, max = 1, step = 0.1, value = 0.2))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"no dimensions (1-4):")),
                               tags$td(width = "30%", numericInput("autismMaskGroups", NULL, min = 1, max = 10, step = 1, value = 2))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"cost (0-1):")),
                               tags$td(width = "30%", numericInput("autismMaskCost", NULL, min = 0, max = 1, step = 0.1, value = 0.4))
                             ),
                             tags$tr(tags$td(width = "70%",
                                             tags$div(style=paste0(localStyle,"font-weight:bold;text-align: left;"),HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Stimming">Stimming</a>'))) ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"amount (0-1):")),
                               tags$td(width = "30%", numericInput("autismStim", NULL, min = 0, max = 1, step = 0.1, value = 0.0))
                             ),
                             tags$tr(
                               tags$td(width = "70%", tags$div(style=localStyle,"gain (0-1):")),
                               tags$td(width = "30%", numericInput("autismStimgain", NULL, min = 0, max = 1, step = 0.1, value = 0.2))
                             )
                  )
        ),
        wellPanel(tags$div(style="margin-top:0px;font-weight:bold;","Display"),
                  tags$table(width="100%",
                             tags$tr(
                               tags$td(width = "50%", tags$div(style=localStyle,"display:")),
                               tags$td(width = "50%", selectInput("display", NULL,c("original","positive"), selected = "Positive",selectize=FALSE))
                             ),
                             tags$tr(
                               tags$td(width = "50%", tags$div(style=localStyle,"dimensions:")),
                               tags$td(width = "50%", selectInput("dimensions", NULL,c("original","sensible","minimal"), selected = "sensible",selectize=FALSE))
                             ),
                             tags$tr(
                               tags$td(width = "50%", tags$div(style=localStyle,"version:")),
                               tags$td(width = "50%", selectInput("version", NULL,format(1:7), selected = "7",selectize=FALSE))
                             ),
                             tags$tr(
                               tags$td(width = "50%", tags$div(style=localStyle," ")),
                               tags$td(width = "50%", actionButton(inputId = "New", label = "Make Person" ))
                             )
                  )
        ),
        tags$div(style="height:20px;",'  '),
        wellPanel(tags$div(style="font-weight:bold;",'Help Links'),
                  tags$table(width="100%",
                             tags$tr(
                               tags$td(tags$div('  ')),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Theory"><b>Theory</b></a>'))),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram/"><b>General</b></a>'))),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram/"><b>Autism</b></a>'))),
                               tags$td(tags$div('  ')),
                               tags$td(tags$div('  '))
                             ),
                             tags$tr(
                               tags$td(tags$div('  ')),
                               tags$td(tags$div('  ')),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Capacity">Capacity</a>'))),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Autism">Demand Score</a>')))
                             ),
                             tags$tr(
                               tags$td(tags$div('  ')),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#ToDo">To do</a>'))),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Sensitivity">Sensitivity</a>'))),
                               tags$td(
                                 tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Masking">Masking</a>'))) 
                             )
                  )
        ),
        wellPanel(tags$div(style="font-weight:bold;",'Code'),
                  tags$table(width="100%",
                             tags$tr(
                               tags$td(tags$div('  ')),
                               tags$td(
                                 tags$div(HTML('<a href="https://github.com/rjwatt42/autismSpectrum"><b>Github</b></a>'))),
                               )
                             )
                  )
        #   wellPanel(style="background:#aaa;border:none;",
      #     tags$div(style="margin-top:0px;font-weight:bold;","Help links"),
      #             tags$table(width="100%",
      #                        tags$tr(tags$td(width = "100%",
      #                                        tags$div(style=refStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram/">General</a>'))) 
      #                                ),
      #                        tags$tr(tags$td(width = "100%",
      #                                        tags$div(style=refStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Theory">Theory</a>'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "100%",
      #                                        tags$div(style=refStyle,HTML('Everyone Traits'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "70%",
      #                                        tags$div(style=refrefStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Capacity">Capacity</a>'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "70%",
      #                                        tags$div(style=refrefStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Sensitivity">Sensitivity</a>'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "100%",
      #                                        tags$div(style=refStyle,HTML('Autism Traits'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "100%",
      #                                        tags$div(style=refrefStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Autism">Demand Score</a>'))) 
      #                        ),
      #                        tags$tr(tags$td(width = "70%",
      #                                        tags$div(style=refrefStyle,HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Masking">Masking</a>'))) 
      #                        )
      #             )
      #   )
      ),
      width=3
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      style = paste("background: ",'#FFF',';','width:526px;height:500px;',"margin: 0px;margin-top:10px;margin-left:60px;padding: 0px;border-radius:0px;"),
      
      # Output: 
      htmlOutput(outputId = "spectrumHTML",width="250px",height="250px",border="0px",margin="0px"),
      htmlOutput(outputId = "autismHTML",width="450px",height="250px"),
      plotOutput(outputId = "spectrumPlot",width="250px",height="250px"),
      plotOutput(outputId = "autismPlot",width="450px",height="250px"),
      width=5
    )
  ),
  # fluidRow(
  #   style = paste("background: ",'#fff',';','width:240px;height:100px;',"margin: 0px;padding: 0px;border-radius:0px;"),
  #   wellPanel(tags$div(style="font-weight:bold;",'Help Links'),
  #             tags$table(width="100%",
  #                        tags$tr(
  #                          tags$td(tags$div('  ')),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Theory"><b>Theory</b></a>'))),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram/"><b>General</b></a>'))),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram/"><b>Autism</b></a>'))),
  #                          tags$td(tags$div('  ')),
  #                          tags$td(tags$div('  '))
  #                        ),
  #                        tags$tr(
  #                          tags$td(tags$div('  ')),
  #                          tags$td(tags$div('  ')),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Capacity">Capacity</a>'))),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Autism">Demand Score</a>')))
  #                        ),
  #                        tags$tr(
  #                          tags$td(tags$div('  ')),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#ToDo">To do</a>'))),
  #                          tags$td(
  #                            tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Sensitivity">Sensitivity</a>'))),
  #                          tags$td(
  #                                  tags$div(HTML('<a href="https://doingpsychstats.wordpress.com/autism-diagram#Masking">Masking</a>'))) 
  #                        )
  #             )
  #   )
  # ),
  fluidRow(
    style = paste("background: ",'#fff',';','width:800px;height:100px;',"margin: 0px;padding: 0px;border-radius:0px;"),
    wellPanel(tags$div(style="font-weight:bold;",'References'),
              tags$table(width="100%",
                         tags$tr(tags$td(width = "70%",
                                         tags$div(HTML('1. <a href="https://pubmed.ncbi.nlm.nih.gov/36628521/">Frazier et al (2023)</a> "The Autism Symptom Dimensions Questionnaire: Development and psychometric evaluation..."<br>Dev Med Child Neurol. 65:1081-1092. doi: 10.1111/dmcn.15497'))) 
                         ),
                         tags$tr(tags$td(width = "70%",height = "5px")),
                         tags$tr(tags$td(width = "70%",
                                         tags$div(HTML('2. <a href="https://www.scientificamerican.com/article/the-autism-spectrum-isnt-a-sliding-scale-39-traits-show-the-complexity/">Parshall and Montanez (2026). </a> "Here’s what the autism spectrum really looks like" Scientific American (Mar 17, 2026)'))) 
                         )
              )    
              )
  )
)
