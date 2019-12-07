# opens the library to read excel
library(readxl)
library(ggplot2)
library(reshape2)
library(plotly)
# reads from the re-arranged table 14.1 the three sheets:
## local units by decade and industry
localunits_1951_2011 <- read_excel("20191110_FromTable14-1.xlsx",sheet='LocalUnits')
## workforce by decade and industry
workforce_1951_2011 <- read_excel("20191110_FromTable14-1.xlsx",sheet='Workforce')
## workforce per local unit by decade and industry
sizeevolution_1951_2011 <- read_excel("20191110_FromTable14-1.xlsx",sheet='SizeTrend')
## fix the label names for the descriptions
names(localunits_1951_2011)[1] = 'industry'
names(localunits_1951_2011)[2] = 'industry_italian'
names(workforce_1951_2011)[1] = 'industry'
names(workforce_1951_2011)[2] = 'industry_italian'
names(sizeevolution_1951_2011)[1] = 'industry'
names(sizeevolution_1951_2011)[2] = 'industry_italian'

# prepare data for processing
## transpose local units so that each row is industry/year/number of local units
table_lu = melt(localunits_1951_2011[,c(1,3:9)], id.vars='industry', variable.name='year', value.name='localunits')
head(table_lu)

## transpose workforce so that each row is industry/year/total workforce size
table_wf = melt(workforce_1951_2011[,c(1,3:9)], id.vars='industry', variable.name='year', value.name='workforce')
head(table_wf)

## transpose average size per unit so that each row is industry/year/average workforce per local unit
table_se = melt(sizeevolution_1951_2011[,c(1,3:9)], id.vars='industry', variable.name='year', value.name='workforce')
head(table_se)

# rounded values for the workforce size by local unit by industry by decade
table_full <- table_lu
table_full[,'workforce'] <- table_wf[,3]
table_full
table_full[,'size'] <- round(table_full['workforce'] / table_full['localunits'],2)
table_full

# extract table with totals only
table_totals <- subset(table_full,industry=='TOTAL')

# create chart for totals - bubble chart
sizetotal_bubble_base <- ggplot(table_totals,aes(x=year,y=localunits),color='lightblue') 
sizetotal_bubble_geometry <- sizetotal_bubble_base + geom_point(show.legend=T,aes(color=size,size=size)) 
sizetotal_bubble_scale <- sizetotal_bubble_geometry + scale_colour_gradient(high='green', low='red')
sizetotal_bubble_theme <- sizetotal_bubble_scale + theme_minimal() + theme(panel.grid.major.y = element_blank())
sizetotal_bubble_final <- sizetotal_bubble_theme + ylab("number of local units") + xlab("decade (the dot represents workforce per local unit)") + guides(colour="legend",size="legend",shape="legend")

ggplot(table_totals, aes(x=year,y=size)) + geom_point()
lm_size <- with(table_totals,lm(size ~ year)) 

print(sizetotal_bubble_final)
