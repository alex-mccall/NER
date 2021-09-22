library(googleAuthR)
library(ggmap)
data_dir <- "../Data/"
key <- readRDS(paste0(data_dir,"google-key"))
locations <- 'London'

register_google(key = key)

prep_new_data <- function(locations) {
  locations <- unique(locations)
  locations <- as.data.frame(locations)
  #local <- slice_sample(local,n=10)
  names(locations) <- 'address'
  return(locations)
}

get_google_data <- function(local) {
  local <- data.frame(local)
  names(local) <- "address"
  local <- mutate(local,address = ifelse(is.na(address),"",address))
  if(!is.null(nrow(local))) {
  df <- mutate_geocode(local, address, output = 'more')
  return(df)
  }
}

add_data <- function(latest,allplaces) {
  rbind(allplaces,latest)
}

make_all_data <- function() {
  a <- data.frame(address = character(1))
  a <- mutate_geocode(a, address, output = 'more')[-1,]
  return(a)
}

check_new_data <- function(new_data,all_places) {
  results <- !(lapply(new_data[[1]], tolower) %in% lapply(all_places$address...1, tolower))
  return(new_data$address[results])
}

check_existing_data <- function(new_data,all_places) {
  results <- (lapply(new_data[[1]], tolower) %in% lapply(all_places$address...1, tolower))
  return(new_data$address[results])
}

save_places <- function(all_places) {
  saveRDS(all_places,paste0(data_dir,'google_db.rds'))
}


extract_data <- function(all_new_places,all_places) {
  results <- (lapply(all_places$address...1, tolower) %in% lapply(all_new_places, tolower))
  return(unique(all_places[results,]))
}

google_find <- function(locations) {
all_places <- readRDS(paste0(data_dir,'google_db.rds'))
all_places <- mutate(all_places, address...1 = ifelse(is.na(address...1),"",address...1))
new_data <- prep_new_data(locations)
additional_locations <- data.frame()
existing_places <- check_existing_data(new_data,all_places)
additional_places <- check_new_data(new_data,all_places)
if(length(additional_places) != 0) {
   if(!is.na(additional_places)) {
additional_locations <- get_google_data(additional_places)
}
}
all_places <- rbind(all_places, additional_locations)
save_places(all_places)
all_new_places <- c(existing_places,additional_places)
results <- extract_data(all_new_places,all_places)
return(results)
}

