#Makensie Banks Exam 1 
library(tidyverse)
library(dplyr)
getwd() #I am checking to see where I am in my working directory so I can retrieve the data.
Covid <- read_csv("C:/Users/menzi/BIOL3100/Data_Course_BANKs/Exams/Exam_1/cleaned_covid_data.csv")

#I am now going to make a logical vector that will sort out all of the capital "A's" from the Province_State column to get the desired states. 
A_states_logical <- grepl("A",Covid$Province_State)

#Now I am making the subset of the data set for the states that begin with "A".
A_states <- Covid %>% filter(A_states_logical)

#Let's make it pretty with a plot showing Deaths over Time.
ggplot(A_states,aes(x=Last_Update,y=Deaths)) +
         geom_point(color="orange", size=1) +
  geom_smooth(method = "lm",se= FALSE, color="cyan")+
  labs(title = "Deaths vs. Time",
      subtitle= "From A_States",
      y= "Deaths",
      x= "Time") +
  facet_wrap(~Province_State,scales= "free") + #This will make a facet wrap of each state and allow ggplot to make it's own parameters.
  theme_classic() +
  theme(legend.position = "none",
        strip.text.x = element_text(size= 12, face="bold"),
        strip.background = element_rect(fill="lightblue")) 

#Here I am going to make a pipe operator to find the Peak of the Case_Fatality_Ratio for each State.
state_max_fatality_rate <- Covid %>% 
  group_by(Province_State) %>% 
  summarize(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE)) %>% #This is the command to find the max number within the Case_Fatality_Ratio column.
  arrange(desc(Maximum_Fatality_Ratio)) #This command is to arrange it in descending order.

#Making another pretty plot
p <- ggplot(state_max_fatality_rate, aes(x = fct_reorder(Province_State, -Maximum_Fatality_Ratio), y = Maximum_Fatality_Ratio)) + #I've made a factor here to arrange the x-axis in descending order based on the Max_Fatality_Ratio.
  geom_bar(stat = "identity", fill="maroon") +
  labs(title="State vs. Maximum Fatality Ratio",
       x= "Province_State",
       y= "Maximum_Fatality_Ratio") +
  theme_classic() 
p + theme(axis.text.x = element_text(angle = 90, hjust = 1)) #This is how I turned the labels 90 degrees to be readable and aligned the text with the right side of the axis ticks.

#My attempt at extra credit
Covid$Last_Update <- as.Date(Covid$Last_Update) #I'm making sure it's in the correct date format
Cumulative_Deaths <- Covid %>% #A pipe operator for a cumulative deaths data set
  group_by(Last_Update) %>%
  summarize(Cumulative_Deaths = sum(Deaths, na.rm = FALSE)) #This is calculating the sum of numeric values and ignoring any NA values.

#Now to make a plot of Death over Time for the entire US.
ggplot(Cumulative_Deaths, aes(x= Last_Update, y= Cumulative_Deaths)) +
  labs(x = "Date", y = "Cumulative Deaths", title = "Cumulative Deaths in the US over Time") +
  geom_line(color = "#fc5a03",linewidth = 1) +
  theme_classic()
  
