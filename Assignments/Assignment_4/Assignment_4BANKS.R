library(tidyverse)
getwd()
Algae <- read_csv("C:/Users/menzi/BIOL3100/Data_Course_BANKS/Assignments/Assignment_4/FakeAlgae - Sheet1.csv")
ggplot(Algae,aes(x=Temperature,y=Cells)) +
  geom_point(color="Turquoise", size= 4, alpha=.25) +
  geom_smooth(method="lm",color="lime green",se=FALSE, linetype=1) +
  labs(title= "Fake Utah Lake Algae",
       subtitle = "From Fake Algae Dataset",
       x= "Temperature",
       y= "Cells",
       caption= "UTAH") +
  theme_classic()

