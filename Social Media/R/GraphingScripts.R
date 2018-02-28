hiss#R Script for Visualizations used for the Twitter data.
library(ggplot2)
ggplot()+
  geom_line(data=HUDF,aes(x=Date, y=GNIPResults),color="red")+
  geom_line(data=HUDF,aes(x=Date, y=HealthUnitResults),color="blue")+
  xlab("Date")+
  ylab("Volume")