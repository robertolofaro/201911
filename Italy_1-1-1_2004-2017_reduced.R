# create data set
Year_kpi <- c(2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017)
Italia <-	c(8.9,8.7,9,9.3,9,10.2,9.5,11,11,11,11,11.5,11.7,12.2)
North	<- c(4.5,4.2,4.3,4.4,4.9,5.8,5.4,5.6,5.6,5.5,6.2,6.1,7.1,6.9)
Centre <- c(5.9,5.5,5.7,6.1,5.6,7.2,6.8,9,9.6,9.3,8.5,9.6,10.9,11.2)
South	<- c(19.2,19.5,19.9,20.6,19.1,20.8,19.3,22.6,21.9,23.1,22.2,23.2,21.1,22.8)

ggplot(data=NULL,aes(x=Year_kpi)) +
  geom_line(aes(x=Year_kpi,y=North, color="North")) +
  geom_line(aes(x=Year_kpi,y=Centre, color="Centre")) +
  geom_line(aes(x=Year_kpi,y=South, color="South")) +
  geom_line(aes(x=Year_kpi,y=Italia, color="Italy")) + 
  xlab("Year") + ylab("% working at risk poverty") + 
  theme_minimal() + theme(legend.title=element_blank())