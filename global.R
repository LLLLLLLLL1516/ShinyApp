library(readxl)

future <- read_excel("future.xlsx")
future$Year = as.character.Date(future$Year)
past <- read_excel("history.xlsx")
past$Year = as.character.Date(past$Year)

percentchange <- read_excel("PercentChange.xlsx")
percentchange$Year = as.character.Date(percentchange$Year)
histratio <- read_excel("histratio.xlsx")
histratio$Year = as.character.Date(histratio$Year)
portion <- read_excel("futureportion.xlsx")
portion$Year = as.character.Date(portion$Year)


cato = c("Energy Market", "Fossil Fuel", "Renewable Energy","Oil","Natural Gas","Coal","Nuclear","Hydropower",
         "Biomass","Biofuel","Wind","Geothermal","Solar")
colum = c("na","Energy Market","Energy Market","Fossil Fuel","Fossil Fuel","Fossil Fuel","Fossil Fuel",
           "Renewable Energy","Renewable Energy","Renewable Energy","Renewable Energy","Renewable Energy","Renewable Energy")
Val = c(10,2,99,10,71,89,22,45,67,89,88,37,56)

df = data.frame(cato,colum,Val)
df[df=="na"] <-NA
#Org1 <- gvisOrgChart(df, idvar = "cato", parentvar = "colum", 
                     #tipvar="Val")