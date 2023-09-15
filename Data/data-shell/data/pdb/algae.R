algae <- data.frame(Name= c("Utah Lake","Green Bay","Western Erie"),
                    Location= c("Utah","Wisconsin","Michigan"),
                    Temperature= c(65,67,70), 
                    stringsAsFactors = FALSE)
ggplot(algae, aes(x=location,y=temperature))+
         geom_point()
