all_markup <- fread("all_markup.csv")
allmarkgg <- ggplot(all_markup, aes(x = year)) + 
  ylim(0.5, 2) +
  geom_ribbon(aes(ymin = p10mk, ymax = p90mk), fill = "blue", alpha = 0.2) +  # Shaded area for P10 to P90
  geom_ribbon(aes(ymin = p25mk, ymax = p75mk), fill = "green", alpha = 0.4) +  # Shaded area for P25 to P75
  geom_line(aes(y = meanMarkup), color = "red") +  # Mean trendline
  labs(title = "Estimated Intermediate Consumption Markup in all industries UK (1997-2021) ",
       x = "Time",
       y = "Markup") +
  theme_minimal()

constr_markup <- fread("constr_markup.csv")
constrmarkgg <- ggplot(constr_markup, aes(x = year)) +
  ylim(0.5, 2) +
  geom_ribbon(aes(ymin = p10mk, ymax = p90mk), fill = "blue", alpha = 0.2) +  # Shaded area for P10 to P90
  geom_ribbon(aes(ymin = p25mk, ymax = p75mk), fill = "green", alpha = 0.4) +  # Shaded area for P25 to P75
  geom_line(aes(y = meanMarkup), color = "red") +  # Mean trendline
  labs(title = "Estimated Intermediate Consumption Markup in the broad construction industry UK (1997-2021) ",
       x = "Time",
       y = "Markup") +
  theme_minimal()

manu_markup <- fread("manu_markup.csv")
manumarkgg <- ggplot(manu_markup, aes(x = year)) +
  ylim(0.5, 2) +
  geom_ribbon(aes(ymin = p10mk, ymax = p90mk), fill = "blue", alpha = 0.2) +  # Shaded area for P10 to P90
  geom_ribbon(aes(ymin = p25mk, ymax = p75mk), fill = "green", alpha = 0.4) +  # Shaded area for P25 to P75
  geom_line(aes(y = meanMarkup), color = "red") +  # Mean trendline
  labs(title = "Estimated Intermediate Consumption Markup in the broad manufacturing industry UK (1997-2021) ",
       x = "Time",
       y = "Markup") +
  theme_minimal()

serv_markup <- fread("serv_markup.csv")
servmarkgg <- ggplot(serv_markup, aes(x = year)) +
  ylim(0.5, 2) +
  geom_ribbon(aes(ymin = p10mk, ymax = p90mk), fill = "blue", alpha = 0.2) +  # Shaded area for P10 to P90
  geom_ribbon(aes(ymin = p25mk, ymax = p75mk), fill = "green", alpha = 0.4) +  # Shaded area for P25 to P75
  geom_line(aes(y = meanMarkup), color = "red") +  # Mean trendline
  labs(title = "Estimated Intermediate Consumption Markup in the broad service industry UK (1997-2021) ",
       x = "Time",
       y = "Markup") +
  theme_minimal()

non_man_markup <- fread("non_man_markup.csv")
non_manmarkgg <- ggplot(non_man_markup, aes(x = year)) +
  ylim(0.5, 4) +
  geom_ribbon(aes(ymin = p10mk, ymax = p90mk), fill = "blue", alpha = 0.2) +  # Shaded area for P10 to P90
  geom_ribbon(aes(ymin = p25mk, ymax = p75mk), fill = "green", alpha = 0.4) +  # Shaded area for P25 to P75
  geom_line(aes(y = meanMarkup), color = "red") +  # Mean trendline
  labs(title = "Estimated Intermediate Consumption Markup in broad non-manufacturing production industries UK (1997-2021) ",
       x = "Time",
       y = "Markup") +
  theme_minimal()

grid.arrange(allmarkgg, constrmarkgg, manumarkgg, servmarkgg, non_manmarkgg, ncol = 2, nrow = 3)

all_markup.ts <- ts(all_markup$meanMarkup, start = (1997), frequency = 1)
