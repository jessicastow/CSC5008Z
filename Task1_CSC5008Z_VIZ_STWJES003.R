# CSC5008Z Data Visualisation
# Visualisation Task 1
# STWJES003

# Read in data
setwd("/Users/jessicastow/Documents/2024 studies/UCT/CSC5008Z")
data <- read.csv('CSC_marks_2019_to_2023.csv', header = T)
data

# Tidy up the column names
colnames(data)[1] <- "Year"
colnames(data)[2] <- "Result"

# Replace "DNF" with "Did Not Finish" in the Result column
data$Result[data$Result == "DNF"] <- "Did Not Finish"

# View changes to dataframe
data

# Reorder columns ####

# We need the package 'dplyr'
install.packages("dplyr")
library(dplyr)

# Create new order
# new_order <- c("Year", "Outcome", "CSC1010H", "CSC1011H", "CSC1015F", "CSC1017F", "CSC1019F", "CSC1016S", "CSC2001F", "CSC2002S",  "CSC2004Z", "CSC3002F", "CSC3003S")
# data <- data %>% select(all_of(new_order))

data

# Write to CSV ####
write.csv(data, "CSC_marks_2019_to_2023_clean.csv")

# Install packages
install.packages("ggplot2")
install.packages("tidyr")

# Load necessary packages
library(ggplot2)
library(tidyr)

# Pivot: Transform by lengthening data (from wide to long format)
pivot_data <- pivot_longer(data, cols = -c(Year, Result), names_to = "Course", values_to = "Count")
pivot_data

# Write to CSV
write.csv(pivot_data, "CSC_marks_2019_to_2023_clean_pivot.csv")

# Time series (line graph)
# Use facet_wrap to create a separate line graph for each course code

ggplot(pivot_data, aes(y = Count, x = Year, color=Result)) + 
  geom_line(stat = "identity") + 
  facet_wrap(~Course, scales = "free", nrow = 4) +
  theme_bw() +
  theme(panel.background = element_blank(), 
        panel.spacing = unit(2, "lines"),
        axis.text.x = element_text(size = 7, family = "Times",  hjust = 0.5),
        axis.text.y = element_text(size = 7, family = "Times", hjust = 1),
        legend.text = element_text(size = 10, family = "Times"),
        axis.title.x = element_text(size = 12, family = "Times", margin=margin(25,0,0,0)),
        axis.title.y = element_text(size = 12, family = "Times", margin=margin(0,25,0,0)),
        plot.title = element_text(hjust = 0.5, size = 18, family = "Times", face = "bold", margin=margin(30,0,40,0)),
        legend.title = element_text(hjust = 0.5, size = 12, family = "Times", face = "bold"),
        strip.text = element_text( size = 9, family = "Times", face = "bold"),
        strip.background = element_rect(fill = "lightgrey", colour = "black", size = 1),
        plot.margin = margin(1,6,1.5,1.2, "cm"),
        legend.justification = c("top"),
        legend.box.background = element_rect(color="black", size=0.5),
        legend.box.margin = margin(12, 5, 5, 5),
        legend.position = c(1.22,0.8)) +
  scale_color_manual(breaks = c("Pass ", "Fail", "Did Not Finish"), values=c("blue", "red", "orange")) +
  labs(title = "Year-on-year final results of undergraduate 
  Computer Science courses by course code", x = "Year", y = "Number of students")