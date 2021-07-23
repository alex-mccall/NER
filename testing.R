
#google_cjhecked_complete
#asked_google
#Interesting_Data
#new_geographies

check_data <- function(data_set) {
row_odd <- seq_len(length(data_set)) %% 2 
test_data <- unlist(data_set,recursive=FALSE)
data_row_odd <- unlist(test_data[row_odd == 1])
data_row_even <- unlist(test_data[row_odd == 0])

test_data <- data.frame(cbind(data_row_odd,data_row_even))
test_data1 <- filter(test_data,data_row_odd == "Patrick")
return(test_data1)
}

check_train <- function(X_train, Y_train, y_pred) {
c2 <- unlist(X_train, recursive = FALSE)
c3 <- lapply(c2,function(x) x[['word']])
c4 <- lapply(c2,function(x) x[['tag']])
c5 <-data.frame(cbind(c3,c4))
c6 <- unlist(Y_train, recursive = FALSE)
c8 <- unlist(y_pred, recursive = FALSE)
c7 <- cbind(c5,c6,c8)
names(c7) <- c("word","tag","test","pred")
#c7 <- filter(c7, str_detect(c4,'GPE'))
return(c7)
}

#check_t1 <- check_train(X_train, Y_train, y_pred)
check_t2 <- check_train(X_dev,Y_dev, y_pred) %>% filter(pred != "O") %>%
  mutate(testing = identical(tag, y_pred)) %>%
  filter(testing==FALSE)


b <- check_data(train) 

z1 <- unlist(training_data[[1]], recursive = FALSE)
z2 <- unlist(training_data[[2]], recursive = FALSE)

z3 <- cbind(z1,z2)
z3 <- data.frame(z3)


z1 <- data.frame(z1)
z2 <- data.frame(z2)
