library(DT)
library(shiny)
library(shinydashboard)
library(dplyr)
library(googleVis)

shinyUI(dashboardPage(  
  dashboardHeader(title = "Energy Market Analysis"),
  dashboardSidebar(
    
    sidebarUserPanel("NYC DSA",
                     image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("industry")),
      menuItem("History Analysis", tabName = "history", icon = icon("history")),
      menuItem("Projection Analysis", tabName = "projection", icon = icon("database"))
    )
    #helpText('This App utilizes data from EIA(Energy Information Administration). The analysis is performed based on the most updated data and is aimed to 
      #show the insights of the energy market from history and future projection')
    
    #selectizeInput("selected",
    #"Select Item to Display",
    #choice)
  ),
  dashboardBody(
    #tags$head(
    #tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    
    tabItems(
      tabItem(tabName = "history",
              fluidRow(
                box(sliderInput("hisyr", "Select Year Range", min = 1949, max = 2016, value = c(1955, 2015))),
                box(selectInput("hisconsump", "Select Consumption Data",
                            choices = list("Fossil Fuel Consumption","Nuclear Consumption","Renewable Consumption","Total Consumption","Import"),
                            selected = "Total Consumption"),
                selectInput("hisprod", "Select Production Data",
                            choices = list("Fossil Fuel Production","Nuclear Production","Renewable Production","Total Energy Production","Export"),
                            selected = "Total Consumption")
                )
                ),
              
              fluidRow(box(htmlOutput("hisplot"), height = 570),
                       box(htmlOutput("histratioplot"),height = 570)
                      
              )
              
      ),
      tabItem(tabName = "projection",
              fluidRow(
                br(),
                box(sliderInput("futureyr", "Select Year Range", min = 2017, max = 2042, value = c(2020, 2030))),
                #sliderInput("futureyr", "Select Year Range", min = 2017, max = 2050, value = c(2020, 2050)),
                box(
                selectInput("futureconsump", "Select Consumption Data",
                            choices = list("Oil Consumption", "Natural Gas Consumption", "Coal Consumption", "Nuclear Consumption", "Hydropower Consumption", "Biomass Consumption",
                                           "Other Renewable Consumption","Total Consumption","Import","Total Renewable Consumption"),
                            selected = "Total Consumption"),
                selectInput("futureprod", "Select Production Data",
                            choices = list("Oil Production", "Natural Gas Production", "Coal Production", "Nuclear Production", "Hydropower Production", "Biomass Production",
                                           "Other Renewable Production","Total Production","Export"),
                            selected = "Total Production")
                )
              ),
              br(),
              fluidRow(box(htmlOutput("futureplot"), height = 400, width = 300)),
              br(),
              fluidRow(box(htmlOutput("ratioplot"), height =350),
                       box(htmlOutput("portionplot"), height =350))
              
      ),
      tabItem(tabName = "overview",
              br(),
              br(),
              fluidRow(htmlOutput("orgchart"), height = 300 ),
              br(),
              br(),
              fluidRow(box(htmlOutput("overallhist")),
                       box(htmlOutput("overallfuture")))
             
            
        
      )
    )
  )
  #skin ="green"
))
