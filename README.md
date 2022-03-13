# COVID-19 Data Analysis Project: Do vaccines really work?

## Introduction

Corona virus disease pandemic not only affects the global politics and economy, but also profoundly and comprehensively affects all aspects of society and life. In people’s cognition, vaccines should play a role in block the spread of corona virus disease. However, whether people get vaccinated can prevent the spread of corona virus requires data support and more research. Also, if the strong correlation between the current epidemic development and the vaccination rate can be studied, and the higher the vaccination rate, the more stable and less severe the epidemic will be in the future, then it will be more convincing to encourage people to get fully vaccinated. This project obtained data from who’s website, including the Latest reported counts of cases and deaths, WHO COVID 19 global data and vaccination data, and set hypothesis that current epidemic situations have a difference between vaccination level and number of vaccine types, there is association between current epidemic situations and country vaccination level, and the number of 1 dose vaccinated people causes newly cases to Granger-cause itself. This report combines past news and research to provide a reasonable explanation for the conclusions reached by this project.

## Background

In adults, the Oxford/AstraZeneca vaccine had 70% efficacy against COVID-19 >14 d after the 2nd dose (Zain Chagla, 2021) However, it is possible that vaccines won’t necessarily work to prevent the spread of corona virus. A two-dose regimen of the ChAdOx1 nCoV-19 vaccine did not show protection against mild-to-moderate Covid-19 due to the B.1.351 variant (Madhi, Shabir A. etal., 2021). Also, incorrect vaccines are likely to cause people to get sick or even die, which in turn contributes to the development of the epidemic. Although people have accumulated a lot of experience in vaccine research for infectious diseases before, vaccines for the severe acute respiratory syndrome (SARS), Ebola, and Zika did not follow a similar path(Fernando P. Polack, 2020). Moreover, the research and development process of vaccines is very expensive and will encounter many challenges, so it is worth studying and discussing whether it is worthwhile to encourage people to get vaccinated and whether it will prevent the development of the epidemic.

The [Latest reported counts of cases and deaths](https://covid19.who.int/WHO-COVID-19-global-table-data.csv) (02/17/2022) was obtained from WHO, and there are 237 records and 12 variables. 

|  Variable name   | Description  |
|  ----  | ----  |
| `Name`  | Country, territory, area |
| `WHO.Region`  | WHO Region |
| `Cases - cumulative total`  | Cumulative confirmed cases. |
| `Cases - cumulative total per 100000 population`  | Cumulative confirmed cases per 100,000 population. |
| `Cases - newly reported in last 7 days`  | New confirmed cases reported in the last 7 days. |
| `Cases - newly reported in last 7 days per 100000 population	`  | New confirmed cases reported in the last 7 days per 100,000 population. |
| `Cases - newly reported in last 24 hours`  | New confirmed cases in the last 24 hours. |
| `Deaths - cumulative total`  | Cumulative confirmed deaths. |
| `Deaths - cumulative total per 100000 population`  | Cumulative confirmed deaths per 100,000 population. |
| `Deaths - newly reported in last 7 days`  | New confirmed deaths reported in the last 7 days. |
| `Deaths - newly reported in last 7 days per 100000 population`  | New confirmed deaths reported in the last 7 days per 100,000 population. |
| `Deaths - newly reported in last 24 hours`  | New confirmed deaths reported in the last 24 hours. |

The [WHO COVID 19 global data](https://covid19.who.int/WHO-COVID-19-global-data.csv) (to 02/17/2022)contains 184,149 records and 8 variables

|  Variable name   | Description  |
|  ----  | ----  |
| `Date_reported`  | Date of reporting to WHO |
| `Country_code	`  | ISO Alpha-2 country code |
| `Country`  | Country, territory, area |
| `WHO_region`  | WHO regional offices: |
| `New_cases`  | New confirmed cases |
| `Cumulative_cases`  | Cumulative confirmed cases |
| `New_deaths`  | New confirmed deaths |
| `Cumulative_deaths`  | Cumulative confirmed deaths |

The [Vaccination data](https://covid19.who.int/who-data/vaccination-data.csv) which contains 228 records and 14 variables was achieved from WHO. 

|  Variable name   | Description  |
|  ----  | ----  |
| `COUNTRY`  | Country, territory, area |
| `ISO3	`  | ISO Alpha-3 country code |
| `WHO_REGION`  | WHO Region |
| `DATA_SOURCE`  | Indicates data source |
| `DATE_UPDATED`  | Date of last update |
| `TOTAL_VACCINATIONS`  | Cumulative total vaccine doses administered |
| `PERSONS_VACCINATED_1PLUS_DOSE`  | Cumulative number of persons vaccinated with at least one dose |
| `TOTAL_VACCINATIONS_PER100`  | Cumulative total vaccine doses administered per 100 population |
| `PERSONS_VACCINATED_1PLUS_DOSE_PER100`  | Cumulative persons vaccinated with at least one dose per 100 population |
| `PERSONS_FULLY_VACCINATED	`  | Cumulative number of persons fully vaccinated |
| `PERSONS_FULLY_VACCINATED_PER100	`  | Cumulative number of persons fully vaccinated per 100 population |
| `VACCINES_USED`  | Combined short name of vaccine |
| `FIRST_VACCINE_DATE`  | Date of first vaccinations |
| `NUMBER_VACCINES_TYPES_USED`  | Number of vaccine types used per country, territory, area |
</font>

# Questions of interest
<font face="Times New Roman" size=4>
Firstly, we will conduct descriptive analysis to achieve basic global epidemic and vaccine situation and epidemic situation in the United State. Then, we will examine the difference in Corona cases by two independent variables and assess the difference the interaction between two independent variables in two-way analysis of variance. Furthermore, we will make a Granger-causality Test used to examine if `PERSONS_VACCINATED_1PLUS_DOSE_PER100` may be used to forecast `Cases...newly.reported.in.last.7.days`. </font>

    ·  Does current epidemic situations (new confirmed cases reported in the last 7 days per 100,000 population) would have difference between vaccination level (cumulative total vaccine doses administered per 100 population) and number of vaccine types(number of vaccine types used per country, territory, area)?
    
    · Whether there is any association between current epidemic situations and country vaccination level?
    
    · Can the the values of cumulative persons vaccinated with at least one dose per 100 population predict values of new confirmed cases reported in the last 7 days per 100,000 population in the future?
