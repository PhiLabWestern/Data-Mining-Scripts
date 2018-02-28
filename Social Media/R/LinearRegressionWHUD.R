#Compare to list of outbreaks given by health unit.
#Health unit is from August 10th to August 28th. Try one version with 0 for other dates and one version with only those dates.

HealthUnitDates <- list(1,0,2,2,3,6,3,2,2,2,5,5,3,1,2,1,1,3)
HealthUnitWithZeros <- list(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,2,3,6,3,2,2,2,5,5,3,1,2,1,1,3,0,0,0)
HealthUnitWithZeros <- list(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,2,2,3,6,3,2,2,2,5,5,3,1,2,0,1,1,3,0,0,0)
#HUDF is Healh Unit Data Frame
HUDF <- do.call(rbind, Map(data.frame, GNIPResults=HealthUnitWith2Zeros, HUResults=HealthUnitWithZeros))

RegressionResult <- lm(GNIPResults~HUResults, data=HUDF)
visreg(RegressionResult)

#SmallerRegression is Dates in the interested Period
#RR is the wider period.
#Normalize tweets by volume we retrieved that day to see if that helps anything.