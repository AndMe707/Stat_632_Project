All_X1 <- readRDS("final_project/data/EDI_Development_Data.rds") %>%  select(-Year, -Country)

Development_Set <- All_X1
Development_Set <- Development_Set %>% mutate(across(everything(),as.numeric))


cormat <- round(cor(Development_Set),2)
cormat[lower.tri(cormat)] <- NA
upper_tri <- cormat
# Melt the correlation matrix
library(reshape2)
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Heatmap
library(ggplot2)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "red", high = "blue", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, 
                                   size = 12, hjust = 1))+
  coord_fixed() +
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

index <- sample(1:nrow(Development_Set), nrow(Development_Set)* .7)
train <- Development_Set[index,]
test <- Development_Set[-index,]

train$Education_Index


model <- lm(Education_Index ~ ., data = train[-c(1)])
performance::check_model(x = model)
summary(model)
model2 <- step(model)
summary(model2)
performance::check_model(x = model2)
anova(model, model2)
plot(model)

shapiro.test(rstandard(model))





preds <- predict(model2, test)
plot(preds ~ test$Education_Index )
abline(0, 1)