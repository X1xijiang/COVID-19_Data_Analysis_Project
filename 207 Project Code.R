#install.packages("HH")
library(car)
#install.packages("kableExtra")
library(kableExtra)
library(stats)
library(lmtest)
covid <- read.csv("/Users/xixi/Library/Mobile Documents/com~apple~CloudDocs/207/Project/Latest reported counts of cases and death.csv")
vac <- read.csv("/Users/xixi/Library/Mobile Documents/com~apple~CloudDocs/207/Project/vaccination-data.csv")
# check NA
sum(is.na(covid))
sum(is.na(vac))

# delete NA in covid
sum(is.na(covid$`Cases - cumulative total per 100000 population`))#1 missing values
#covidc<- covid[-which(is.na(covid$`Cases - cumulative total per 100000 population`)), ]#remove those 1 missing values
sum(is.na(covid$`Cases - newly reported in last 7 days per 100000 population`))
sum(is.na(covid$`Deaths - cumulative total per 100000 population`))
sum(is.na(covid$`Deaths - newly reported in last 7 days per 100000 population`))
#238 data

#delete NA of 'PERSONS_FULLY_VACCINATED_PER100', 'TOTAL_VACCINATIONS_PER100', 'PERSONS_VACCINATED_1PLUS_DOSE_PER100', 'NUMBER_VACCINES_TYPES_USED' in vac
sum(is.na(vac$TOTAL_VACCINATIONS_PER100))
sum(is.na(vac$PERSONS_VACCINATED_1PLUS_DOSE_PER100))#3 missing values
vacc<- vac[-which(is.na(vac$PERSONS_VACCINATED_1PLUS_DOSE_PER100)), ]#remove those 3 missing values
sum(is.na(vacc$PERSONS_FULLY_VACCINATED_PER100))
sum(is.na(vacc$NUMBER_VACCINES_TYPES_USED))#3 missing values 
vacc<- vacc[-which(is.na(vacc$NUMBER_VACCINES_TYPES_USED)), ]
#222 data

#change name
covid$Name[which(covid$Name == 'Kosovo[1]')] <- "Kosovo"
covid$Name[which(covid$Name == "occupied Palestinian territory, including east Jerusalem")]<-"occupied Palestinian territory"
#merge data
data<-merge(covid,vacc,by.x = 'Name', by.y = 'COUNTRY') 
#221 data
data <- data[ , !names(data) %in% c("WHO.Region", "Cases...newly.reported.in.last.24.hours","Deaths...newly.reported.in.last.24.hours","TOTAL_VACCINATIONS","ISO3", "WHO_REGION", "DATA_SOURCE","DATE_UPDATED","VACCINES_USED","FIRST_VACCINE_DATE")]

#WHO-COVID-19-global-data
global<-read.csv("/Users/xixi/Library/Mobile Documents/com~apple~CloudDocs/207/Project/WHO-COVID-19-global-data.csv")
sum(is.na(global))
777/184149 
na.omit(global)
require(gridExtra)

library(plyr)
library(ggplot2)
Cases...newly.reported.in.last.7.days.per.100000.population<-arrange(data, -Cases...newly.reported.in.last.7.days.per.100000.population)
Country<-reorder(Cases...newly.reported.in.last.7.days.per.100000.population$Name,-Cases...newly.reported.in.last.7.days.per.100000.population$Cases...newly.reported.in.last.7.days.per.100000.population)
plot_1<-ggplot(Cases...newly.reported.in.last.7.days.per.100000.population,aes(x=Country,y=`Cases...newly.reported.in.last.7.days.per.100000.population`))+
  geom_point(color="black")+
  geom_line(aes(group=""), color="grey")+
  labs(x="")+
  theme(axis.title.x = element_blank(),
        axis.line.x= element_blank(),
        axis.text.x = element_blank())
plot_2 <- ggplot(data,aes(y=Cases...newly.reported.in.last.7.days.per.100000.population)) + geom_boxplot()
grid.arrange(plot_1, plot_2 ,ncol=2)
outliers <-boxplot(data$Cases...newly.reported.in.last.7.days.per.100000.population)$out
outliers2 <-boxplot(data$Cases...newly.reported.in.last.7.days.per.100000.population)$out
cnr<- data[-which(data$Cases...newly.reported.in.last.7.days.per.100000.population %in% outliers),]
summary(cnr$Cases...newly.reported.in.last.7.days.per.100000.population)
#define countries
covidnew<-data
#summary(data$Cases...newly.reported.in.last.7.days.per.100000.population)
covidnew$Cases...newly.reported.in.last.7.days.per.100000.population[which(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population <=69.194 )] <- "current mild epidemic"#<Mean
covidnew$Cases...newly.reported.in.last.7.days.per.100000.population[which(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population < 405.447 )] <- "current moderate epidemic"#Mean-3rd Qu.
covidnew$Cases...newly.reported.in.last.7.days.per.100000.population[which(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population < 8764.97 )] <- "current severe epidemic"#>3rd Qu.
#factor(covidnew$`Cases - newly reported in last 7 days per 100000 population`)
covidnew$Cases...newly.reported.in.last.7.days.per.100000.population[which(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population ==899.484 )] <- "current severe epidemic"
covidnew$Cases...newly.reported.in.last.7.days.per.100000.population[which(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population ==898.429 )] <- "current severe epidemic"
#count(covidnew$Cases...newly.reported.in.last.7.days.per.100000.population)

#factor(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
summary(data$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100[which(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 >= 75.955 & covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 <= 123.710 )] <- "highly vaccinated"#>3rd Qu.
covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100[which(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 <=54.257 )] <- "lowly vaccinated"#<Mean
covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100[which(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 < 75.955 & covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 > 54.257)] <- "moderately vaccinated"# Mean.-3rd Qu.
covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100[which(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 ==8.491 )] <- "lowly vaccinated"#<1st Qu.
covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100[which(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100 ==8.525 )] <- "lowly vaccinated"#<1st Qu.

#factor(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
count(covidnew$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
Cases...cumulative.total_max10<-arrange(data, -Cases...cumulative.total)[1:10,]
Country<-reorder(Cases...cumulative.total_max10$Name,-Cases...cumulative.total_max10$Cases...cumulative.total)
Cases...newly.reported.in.last.7.days.per.100000.population.max10<-arrange(data, -Cases...newly.reported.in.last.7.days.per.100000.population)[1:10,]
Country2<-reorder(Cases...newly.reported.in.last.7.days.per.100000.population.max10$Name,-Cases...newly.reported.in.last.7.days.per.100000.population.max10$Cases...newly.reported.in.last.7.days.per.100000.population)
Deaths...cumulative.total_max10<-arrange(data, -Deaths...cumulative.total)[1:10,]
#bar plot of Cases...cumulative.total_max10
plot1<-ggplot(Cases...cumulative.total_max10,aes(x=Country,y=`Cases...cumulative.total`))+
  geom_bar(stat = 'identity',position="dodge")+
  geom_col(aes(fill=Name),show.legend=F)+  
  theme(axis.text.x = element_text(angle=60,hjust=1))
#bar plot of Cases...newly.reported.in.last.7.days.per.100000.population.max10
plot2<-ggplot(Cases...newly.reported.in.last.7.days.per.100000.population.max10,aes(x=Country2,y=`Cases...newly.reported.in.last.7.days.per.100000.population`))+
  geom_bar(stat = 'identity',position="dodge")+
  geom_col(aes(fill=Name),show.legend=F)+  
  theme(axis.text.x = element_text(angle=60,hjust=1))
grid.arrange(plot1, plot2 ,ncol=2)

global$Date_reported <- as.Date(global$Date_reported)
#number of new cases
a<-ggplot(global, aes(x=Date_reported, y=New_cases, color=WHO_region)) + 
  geom_bar(position = 'stack',stat="identity", width=0.6, color = "grey") + 
  #geom_col(position = 'stack', width = 0.6)+
  geom_line()+scale_x_date(name="Monthly",date_breaks  ="1 month",date_labels="%Y-%m") +  
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))+
  ggtitle("new cases")

#number of cumulative cases
b<-ggplot(global, aes(x=Date_reported, y=Cumulative_cases, color=WHO_region)) + 
  geom_line()+scale_x_date(name="Monthly",date_breaks  ="1 month",date_labels="%Y-%m") +  
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))+
  ggtitle("cumulative cases")
grid.arrange(a,b,nrow=2)
#number of new deaths 
ggplot(global, aes(x=Date_reported, y=New_deaths, color=WHO_region)) + 
  geom_col(position = 'stack', width = 0.6)+
  geom_line()+scale_x_date(name="Monthly",date_breaks  ="1 month",date_labels="%Y-%m") +  
  theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))

#Distribution of the number of vaccine types used per country, territory, area
par(pin = c(6,4.5))
freq <- table(data$NUMBER_VACCINES_TYPES_USED)
class<-levels(data$NUMBER_VACCINES_TYPES_USED)
piepercent <- round(freq/sum(freq)*100,2)
pie(freq,labels = paste(c("1 type:","2 types:","3 types:","4 types:","5 types:","6 types:","7 types:","8 types:","9 types:","11 types:"),piepercent,"%"))

# Exploratory analysis
require(dplyr)
library(gplots)
df<-data.frame(data$Cases...newly.reported.in.last.7.days.per.100000.population,covidnew[ ,names(covidnew) %in% c("PERSONS_VACCINATED_1PLUS_DOSE_PER100","NUMBER_VACCINES_TYPES_USED")])
df$PERSONS_VACCINATED_1PLUS_DOSE_PER100=as.factor(df$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
df$NUMBER_VACCINES_TYPES_USED=as.factor(df$NUMBER_VACCINES_TYPES_USED)
df <- df%>%filter(NUMBER_VACCINES_TYPES_USED!="9")
df <- df%>%filter(NUMBER_VACCINES_TYPES_USED!="11")
df$PERSONS_VACCINATED_1PLUS_DOSE_PER100=unlist(df$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
df$NUMBER_VACCINES_TYPES_USED=unlist(df$NUMBER_VACCINES_TYPES_USED)
names(df)<-c("nrc","pv1","nct")
df$PERSONS_VACCINATED_1PLUS_DOSE_PER100=unlist(df$PERSONS_VACCINATED_1PLUS_DOSE_PER100)
df$NUMBER_VACCINES_TYPES_USED=unlist(df$NUMBER_VACCINES_TYPES_USED)
names(df)<-c("nrc","pv1","nct")

## Levene Test:Homogeneity of variance
dt<-leveneTest(nrc~pv1*nct,data=df)
dt %>%
  kbl() %>%
  kable_material(c("striped", "hover"))

dff<-df
dff$`nrc`<-log10(1+(dff$nrc)^(1/2))
kt<-leveneTest(nrc~pv1*nct,data=dff)
kt %>%
  kbl() %>%
  kable_material(c("striped", "hover"))
#QQ-plot :Normality of the distribution
par(mfrow = c(1, 2))
qqPlot(lm(nrc~pv1, data = dff), simulate = TRUE, main = 'QQ Plot', labels = FALSE)
qqPlot(lm(nrc~nct, data = dff), simulate = TRUE, main = 'QQ Plot', labels = FALSE)
#sum(is.na(df))
par(mfrow=c(1,2))
# Main effect plot for ingredient 1
plotmeans(nrc~pv1,data=dff,xlab="vaccination level",ylab="weekly newly cases per 100000",
          main="Main  effect, vaccination level",cex.lab=1.5) 
# Main effect plot for ingredient 2
plotmeans(nrc~nct,data=dff,xlab="vaccines types",ylab="weekly newly cases per 100000", 
          main="Main  effect, vaccines types",cex.lab=1.5) 
#Interaction plot
interaction.plot( dff$nct,dff$pv1, dff$nrc,cex.lab=1.5,ylab="weekly newly cases per 100000",xlab='vaccines types')
# Test for interactions 
full_model=lm(nrc~as.factor(dff$pv1)+as.factor(dff$nct)+as.factor(dff$pv1)*as.factor(dff$nct),data=dff);
reduced_model=lm(nrc~as.factor(dff$pv1)+as.factor(dff$nct),data=dff);
at<-anova(reduced_model,full_model)
at %>%
  kbl() %>%
  kable_material(c("striped", "hover"))

# Fit the chosen model:
sig.level=0.05;
anova.fit<-aov(nrc~pv1+nct,data=dff)
summary(anova.fit)

bt<- data.frame("row1" = c(" ", "Df", "Sum Sq", "Mean Sq", "F value", "Pr(>F)"), "row2" = c("pv1", "2", "14.48", "7.241", "34.782","9.31e-14 ***"))
variable = c("pv1","nct","Residuals")
Df = c(2,7,208)
Sum_Sq = c(14.48,8.30,43.30)
Mean_Sq=c(7.241,1.186,0.208)
F_value=c(34.782,5.695," ")
Pr=c("9.31e-14 ***","4.90e-06 ***"," ")
bt = data.frame(variable,Df,Sum_Sq,Mean_Sq,F_value,Pr);
bt %>%
  kbl() %>%
  kable_material(c("striped", "hover"))

par(mfrow=c(2,2))
# Obtain the residuals from the ANOVA fit
residuals=anova.fit$residuals;
hist(residuals)
# Plot the residuals (or the other two versions) against fitted values
plot(residuals~anova.fit$fitted.values,type='p',pch=16,cex=1.5,xlab="Fitted values",ylab="Residuals")
# Stem-leaf plot  (or use histogram, or qq-plot )
qqnorm(residuals);qqline(residuals)

gt<-grangertest(`Cases...newly.reported.in.last.7.days` ~ `PERSONS_VACCINATED_1PLUS_DOSE_PER100`, order = 2, data =data)
gt %>%
  kbl() %>%
  kable_material(c("striped", "hover"))