library(crfsuite)
x <- ner_download_modeldata("conll2002-nl")

subset(x, doc_id == 100)

library(data.table)
x <- as.data.table(x)
x <- x[, pos_previous   := shift(pos, n = 1, type = "lag"), by = list(doc_id)]
x <- x[, pos_next       := shift(pos, n = 1, type = "lead"), by = list(doc_id)]
x <- x[, token_previous := shift(token, n = 1, type = "lag"), by = list(doc_id)]
x <- x[, token_next     := shift(token, n = 1, type = "lead"), by = list(doc_id)]

x <- x[, pos_previous   := txt_sprintf("pos[w-1]=%s", pos_previous), by = list(doc_id)]
x <- x[, pos_next       := txt_sprintf("pos[w+1]=%s", pos_next), by = list(doc_id)]
x <- x[, token_previous := txt_sprintf("token[w-1]=%s", token_previous), by = list(doc_id)]
x <- x[, token_next     := txt_sprintf("token[w-1]=%s", token_next), by = list(doc_id)]
subset(x, doc_id == 100, select = c("doc_id", "token", "token_previous", "token_next"))

x <- as.data.frame(x)

crf_train <- subset(x, data == "ned.train")
crf_test <- subset(x, data == "testa")

model <- crf(y = crf_train$label, 
             x = crf_train[, c("pos", "pos_previous", "pos_next", 
                               "token", "token_previous", "token_next")], 
             group = crf_train$doc_id, 
             method = "lbfgs", file = "tagger.crfsuite",
             options = list(max_iterations = 25, feature.minfreq = 5, c1 = 0, c2 = 1)) 
model

stats <- summary(model)

plot(stats$iterations$loss, pch = 20, type = "b", 
     main = "Loss evolution", xlab = "Iteration", ylab = "Loss")

scores <- predict(model, 
                  newdata = crf_test[, c("pos", "pos_previous", "pos_next", 
                                         "token", "token_previous", "token_next")], 
                  group = crf_test$doc_id)
crf_test$entity <- scores$label
table(crf_test$entity, crf_test$label)


install.packages("shiny")
install.packages("flexdashboard")
install.packages("DT")
install.packages("writexl")


rmarkdown::run(file = system.file(package = "crfsuite", "app", "annotation.Rmd"))

