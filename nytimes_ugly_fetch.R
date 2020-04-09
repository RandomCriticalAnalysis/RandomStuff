beaCW=read_csv("https://gist.githubusercontent.com/RandomCriticalAnalysis/2dfa9e830446f7250922a6c6b749722a/raw/6a76cdd3c51866bbbc00a3c5099fde8153edd3d3/bea_economic_areas_county_crosswalk.csv")

nytd=read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv") %>%
  mutate( fips = as.integer(fips) ) 



# There are a small number of actual counties
# in NYTimes file that cannot be matched (~50)
# to BEA's GDP table
# Population and GDP totals should correspond to
# areas that could be matched (almost all)
metros=nytd %>%
  merge(beaCW,by='fips') %>%
  group_by(date,bea_ea_code,bea_ea_name) %>%
  summarise(
    gdp2018=sum(gdp2018,na.rm=T),
    cases=sum(cases,na.rm=T),
    deaths=sum(deaths,na.rm=T),
    pop10=sum(pop10,na.rm=T) # 2010 population!
  ) %>%
  ungroup() 


write.csv(metros,"NYTimes_by_metro.csv",row.names=F)
