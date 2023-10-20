library(tidyverse)
library(ggplot2)
library(janitor)
library(dplyr)
library(easystats)

#I'm making a general path to retrieve the data
Mortality <- read.csv("./unicef-u5mr.csv") %>%  
#Cleaning into longer form
  clean_names() %>% 
  pivot_longer(cols = starts_with("u5mr_"), #there are 69 cols of years and I want to shrink it to just one "year" col
               names_to = "year",
               values_to = "mortality_rate") %>% 
  na.omit() %>% #there are a lot of missing values so I am going to ignore all the rows with missing values
  mutate(year = sub("u5mr_", "", year)) #I didn't like that all of the years had the prefix "u5mr_" so now it will just show the year

Mortality$year <- as.numeric(Mortality$year)#the "year" was still in a chr format so I changed it to numeric

###Plot 1 ###
#Now that I have my clean data I can start to make a plot.
ggplot(Mortality, aes(x = year, y = mortality_rate, group = country_name)) + #I had to make a group so R knew to group the lines by country
  geom_line() +
  facet_wrap(~continent, ncol = 2) +
  labs(title = "Child Mortality Rate Over Time",
       x = "Year",
       y= "Child Mortality Rate") + 
  theme_minimal() +
  scale_x_continuous(breaks = seq(1950, 2015, by = 20)) + #all of the years were squished together, this is how I made increments of 20
  theme(legend.position = "none",
        strip.text.x = element_text(size= 10),
        strip.background = element_rect(fill="lightblue"))

ggsave("BANKS_Plot_1.png", width = 8, height = 6, units = "in") #saving as .png

#calculate the mean u5mr for each year and continent
mean_u5mr <- Mortality %>% 
  group_by(continent, year) %>% 
  summarise(mean_u5mr = mean(mortality_rate, na.rm = TRUE))

###Plot 2###
#I'm creating a second plot to show mean u5mr for all countries within a given continent at each year
ggplot(mean_u5mr, aes(x = year, y = mean_u5mr, group = continent, color = continent)) +
  geom_line(linewidth = 2) +
  labs(title = "Mean Under-5 Mortalitly Rate Over Time by Continent",
       x = "Year",
       y = "Mean U5MR") + 
  theme_minimal() +
  scale_x_continuous(breaks = seq(min(mean_u5mr$year), max(mean_u5mr$year), by = 20)) +
  guides(color = guide_legend(title = "Continent"))

ggsave("BANKS_Plot_2.png", width = 8, height = 6, units = "in")


###Three different models 0f U5MR###
mod1 <- glm(data = Mortality,
            formula = mortality_rate ~ year)#this is a model of only the year 

mod2 <- glm(data = Mortality,
            formula = mortality_rate ~ year + continent) #model of year and continent

mod3 <- glm(data = Mortality,
            formula = mortality_rate ~ year * continent) #model of the year and continent and their interaction term 


###Comparing The Models###

#My prediction is that mod3 will be the best because it is using an interaction term.
mod1$aic
mod2$aic
mod3$aic 

#I will now compare the models by making a plot.
compare_performance(mod1,mod2,mod3) %>% plot


###Plotting the model predictions###
#Im going to combine the models into a list then create a data frame for the models using a for loop

models <- list(mod1 = mod1, mod2 = mod2, mod3 = mod3)
prediction_data <- data.frame()
for (model_name in names(models)) {
  model <- models[[model_name]]
  predictions <- predict(model, newdata = Mortality, type = "response") 
  model_predictions <- data.frame(
    Year = Mortality$year,
    Predicted_U5MR = predictions,
    Model = model_name,
    Continent = Mortality$continent
  )
  prediction_data <- rbind(prediction_data, model_predictions)
}

#Plot of the 3 models' predictions
ggplot(data = prediction_data, aes(x = Year, y = Predicted_U5MR, color = Continent)) +
  geom_line(linewidth = 1) +
  facet_wrap(~ Model, ncol = 1) +
  labs(title = "Predicted U5MR Over Time by Model",
       x = "Year",
       y = "Predicted U5MR") +
  theme_minimal() + 
  theme(strip.background = element_rect(fill="lightgreen"))
  
