---
  title: "Group 11"
format: html
editor: visual
---
  


# read in data 
install.packages("readr") 
library(readr) 
data <- read.csv("alldata_together_optimizedforanalysis - Kopie.csv", sep = ";") 
library(magrittr) 
library(dplyr)
```

# replace Q03 riskyfund with 5,replaceQ03 safefund with 1

```{r}
str(data) 
newdf1 <- data %>% mutate(Q03 = ifelse(Q03=="riskyfund", "5", Q03)) 
newdf1 <- newdf1 %>% mutate(Q03 = ifelse(Q03=="safefund", "1", Q03))
```

# replace Q05 with specific value

```{r}
newdf1 <- newdf1 %>% mutate(Q05 = ifelse(Q05=="Op1.2", "3", Q05)) 
newdf1 <- newdf1 %>% mutate(Q05 = ifelse(Q05=="Op1.3", "5", Q05)) 
newdf1 <- newdf1 %>% mutate(Q05 = ifelse(Q05=="Op1.1", "1", Q05))
```

# replace Q06 with specific value

```{r}
newdf1 <- newdf1 %>% mutate(Q06 = ifelse(Q06=="Op2.2", "3", Q06)) 
newdf1 <- newdf1 %>% mutate(Q06 = ifelse(Q06=="Op2.1", "1", Q06)) 
newdf1 <- newdf1 %>% mutate(Q06 = ifelse(Q06=="Op2.3", "5", Q06))
```

# Aggregation of risk-taking index

```{r}
str(newdf1)
newdf1$Q08.1 <- NULL
str(newdf1)
newdf1$Gender = as.factor(newdf1$Gender)
newdf1$Nation = as.factor(newdf1$Nation)
filtered_data <- newdf1[complete.cases(newdf1[, -ncol(data)]), ]
filtered_data$final_score <- rowSums(as.matrix(filtered_data[, c(5:10,15, 16 )]))

```

# Plotting histogram

```{r}
pdf("my_plot1.pdf")
hist(filtered_data$Age,main = "Age Distribution of Survey Participants",xlab = "Age")
dev.off
```

# Plot

```{r}
pdf("my_plot2.pdf")
plot(x = filtered_data$Age, y = filtered_data$final_score, main ="The Relationship Between Age and Risk-Taking", xlab = "Age", ylab = "risk-taking index")
dev.off
```

```{r}
pdf("my_plots.pdf")
boxplot(filtered_data$final_score~filtered_data$Nation, xlab = "Nation", ylab = "risk-taking index", main = "Risk-Taking Index Across Nations",las = 0,notch=TRUE)
boxplot(filtered_data$final_score~filtered_data$Gender,xlab = "Gender", ylab = "risk-taking index", main="Risk-Taking Index by Gende")
dev.off
```
