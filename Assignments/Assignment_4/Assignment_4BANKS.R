library(tidyverse)
dat <- read_csv("./Assignments/Assignment_4/AlgaeFake.csv")
dat$`Cells Present`
ggplot(dat,aes(x=Temperature,y=`Cells Present`)) +
  geom_point(color="Turquoise", size= 4, alpha=.25) +
  geom_smooth(method="lm",color="lime green",se=FALSE, linetype=1) +
  labs(title= "Fake Utah Lake Algae",
       subtitle = "From the Fake Algae Dataset",
       x= "Temperature",
       y= 'Cells Present',
       caption= "UTAH") +
  theme_grey()

