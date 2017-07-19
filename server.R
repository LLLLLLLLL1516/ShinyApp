
library(shiny)
library(googleVis)
library(dplyr)


shinyServer(function(input, output){
  
  #reactive function to filter the history dataset
  reacthis <- reactive({
    past %>% 
    filter(Year >= input$hisyr[1] & Year <= input$hisyr[2])
  })
  
  reactfuture <- reactive({
    future %>% 
      filter(Year >= input$futureyr[1] & Year <= input$futureyr[2])
  })
  reactfutureportion <- reactive({
    portion %>% 
      filter(Year >= input$futureyr[1] & Year <= input$futureyr[2])
  })
  
  
  reactratio <- reactive({
    percentchange %>% 
      filter(Year >= input$futureyr[1] & Year <= input$futureyr[2]) 

  })
  
  reacthistratio <- reactive({
    histratio %>% 
      filter(Year >= input$hisyr[1] & Year <= input$hisyr[2]) 
    
  })
  
  #reacthis <- as.data.frame(reacthis)
  
  #reacthis <- past %>% filter(Year >= input$hisyr[1] & Year <= input$hisyr[2])
  ## show lineplot using googleVis
  
  output$ratioplot <- renderGvis({
    gvisColumnChart(data = reactratio(), xvar = "Year", yvar = input$futureconsump,
                    options = list(legend="bottom",
                                   title="Percent Change of Consumption", vAxis="{title:'Percent Changed (%)'}",
                                   hAxis="{title:'Year'}", width = 620, height = 330
                      
                    ))
  })
  
  output$histratioplot <- renderGvis({
    gvisColumnChart(data = reacthistratio(), xvar = "Year", yvar = input$hisconsump,
                    options = list(legend="bottom",
                                   title="Percent Change of Consumption", vAxis="{title:'Percent Changed (%)'}",
                                   hAxis="{title:'Year'}", width = 590, height = 470
                    ))
  })
  
  output$hisplot <- renderGvis({
    gvisLineChart(data = reacthis(), xvar = "Year", yvar = c(input$hisconsump, input$hisprod),
                  list(legend = "bottom", 
                       title = "Energy Consumption vs. Energy Production from History Data",
                       vAxis = "{title:'Quantity (Quad Btu)'}",
                       hAxis = "{title:'Year'}", width = 590, height = 470))
  })
  
  output$futureplot <- renderGvis({
    gvisLineChart(data = reactfuture(), xvar = "Year", yvar = c(input$futureconsump, input$futureprod),
                  list(
                    legend = "bottom", 
                    title = "Energy Consumption vs. Energy Production from Projection Data",
                    vAxis = "{title:'Quantity (Quad Btu)'}",
                    hAxis = "{title:'Year'}",
                    height = 350, width = 1500
                  ))
  })
  
  output$portionplot <- renderGvis({
    gvisLineChart(data = reactfutureportion(), xvar = "Year", yvar = input$futureconsump,
                  list(
                    legend = "bottom", 
                    title = "Energy Consumption Market Share",
                    vAxis = "{title:'Percent %'}",
                    hAxis = "{title:'Year'}", height = 330,width = 620
                  ))
  })
  
  output$overallhist <- renderGvis({
    gvisColumnChart(past, 
                         xvar="Year", 
                         yvar=c("Fossil Fuel Consumption", "Nuclear Consumption", "Renewable Consumption"
                               ),
                         options=list(isStacked=TRUE,
                                  legend = "bottom", 
                                  title = "Energy Market Overview From the Past",
                                  vAxis = "{title:'Quantity (Quad Btu)'}",
                                  hAxis = "{title:'Year'}",
                                  height = 500, width = 620
                                )
                    )
  })
  
  output$overallfuture <- renderGvis({
    gvisColumnChart(future, 
                         xvar="Year", 
                         yvar=c("Oil Consumption", "Natural Gas Consumption", "Coal Consumption", "Nuclear Consumption", "Hydropower Consumption","Biomass Consumption",
                                "Other Renewable Consumption"
                           
                         ),
                         options=list(isStacked=TRUE,
                                      legend = "bottom", 
                                      title = "Energy Market Overview Into the Future",
                                      vAxis = "{title:'Quantity (Quad Btu)'}",
                                      hAxis = "{title:'Year'}",
                                      height = 500, width = 620
                                    
                                      ))
  })
  
  output$orgchart <- renderGvis({
    gvisOrgChart(df, idvar = "cato", parentvar = "colum", 
                 tipvar="Val"
                 )
  })
  

  

  

})