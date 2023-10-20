library(tidyverse)
library(janitor)
library(ggplot2)
library(dplyr)

#Load a gneeral pathway from Assignment 7 repository
Religion <- read.csv("./Utah_Religions_by_County.csv") %>% 
  clean_names() %>% 
  #This data is really wide so I'm going to make it longer by listing the percent of all the religions in each country 
  pivot_longer(cols = c(assemblies_of_god, episcopal_church, greek_orthodox, lds, southern_baptist_convention, united_methodist_church, pentecostal_church_of_god, buddhism_mahayana, catholic, evangelical, muslim, non_denominational, orthodox),
               names_to = "religion",
               values_to = "percent") 

#I am making a subset of the data to see the percent of lds religion in the population
target_church <- "lds" 
filtered_data <- Religion %>% 
  filter(religion == target_church)

#This is my first plot that shows the percent of the lds religion in the population
ggplot(filtered_data, aes(x=pop_2010, y=percent, color = religious)) +
  geom_point(size= 3) +
  labs(title = paste("Correlation between Population and",target_church),
       x = "Population",
       y = paste(target_church,"Percentage")) +
  geom_smooth(method = "lm", color = "blue", se= FALSE, linetype= 1) +
  theme_minimal()


#In my second plot I am looking to see what county is the most religious
P2 <- ggplot(Religion, aes(x= fct_reorder(county, -religious), y= religious))+
  geom_bar(stat = "identity",fill= "turquoise")+
  labs(title = "Correlation between County and Religous",
       x = "County",
       y = "Religious") +
  theme_minimal() 
P2 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
#looks like San Juan County is the least religious

#This plot should show the relationship between population and religion
P3 <- ggplot(Religion, aes(x = religion, y= pop_2010))+
  geom_bar(stat = "identity", fill = "maroon")+
  labs(title = "Population of County by Religion",
       x = "Religion",
       y = "Population")+
  theme_minimal()+
  facet_wrap(~county)
P3 +  theme(axis.text.x = element_text(angle = 90, hjust = 1))


saveRDS(Religion, "./Assignment_7BANKS.rds")
        