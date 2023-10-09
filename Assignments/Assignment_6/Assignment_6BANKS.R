library(tidyverse)
library(janitor)
library(gganimate)
library(skimr)
library(dplyr)

Plate <- read_csv ("../../Data/BioLog_Plate_Data.csv") %>%   #retrieving the data in a general pathway
  clean_names() %>% #cleaning the names within the dataframe
  pivot_longer(cols = starts_with("hr_"),
               names_to = "hour", #we are changing the column names that start with "hr_" to be "hour" 
               values_to = "absorbance",
               names_prefix = "hr_",#because all of the values of "hour" begin with "hr" we can specify the values with the name prefix and change it to numeric instead of character
               names_transform = as.numeric) %>% #if all the values didn't begin with "hr" we would have to mutate to clean this column
    mutate(type = case_when(sample_id == "Soil_1" ~ "Soil", #using the mutate function with this column because not all of the sample id's are the same like the hour values were
                            sample_id == "Soil_2" ~ "Soil",
                            sample_id == "Clear_Creek" ~ "Water",
                            sample_id == "Waste_Water" ~ "Water"))


    
Plot_1 <- Plate %>%   #making a plot that will show the type (water or soil) for every substrate
   filter(Plate$dilution == ".1") %>% 
  ggplot(aes(x = hour, y = absorbance, color = type)) +
  geom_smooth(se = FALSE) +
  labs(title = "Just Dilution 0.1",
       x = "Time",
       y = "Absorbance") +
  facet_wrap(~substrate) +
    theme_minimal()

Plot_2 <- Plate %>%  #making a plot that shows the dilutions by the hours of the substrate Itaconic Acid
  filter(Plate$substrate == "Itaconic Acid") %>% #I'm making a filter so It only takes the substrate that is "Itaconic Acid" and ignores all other substrates
  group_by(dilution, sample_id, hour) %>% 
  summarize(mean_abs = mean(absorbance)) %>% 
  ggplot(aes(x = hour, y = mean_abs, color = sample_id))+ 
    geom_path() +
  labs(title = "Itaconic Acid", 
       x = "Time",
       y = "Mean_Absorbance") +
    facet_wrap(~dilution) + #I am making three groups from the three different dilutions :.001, .01 and .1
    theme_minimal() +
    transition_reveal(hour) #This should reveal the amount of absorbency  by the hour: 24, 48 and 144
  
  saveRDS(Plate,"./Assignment_6BANKS.rds")
  