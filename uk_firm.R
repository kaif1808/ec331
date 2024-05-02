# Create the xsga variable
uk_firm[, xsga := sale - opprof + cogs]

uk_firm <- uk_firm %>%
  group_by(rnum, date) %>%
  mutate(nrobs = n()) %>%
  ungroup() %>%
  arrange(rnum, date)

# Function to convert alphanumeric strings to a numeric identifier
convert_to_unique_numeric <- function(reg_numbers) {
  sapply(reg_numbers, function(x) {
    # Remove any unwanted characters first, if necessary
    x_clean <- gsub("#", "", x)  # For example, removing '#' characters
    
    # Convert characters to their ASCII values and then to a string
    ascii_values <- sapply(unlist(strsplit(x_clean, "")), function(char) {
      sprintf("%03d", as.integer(charToRaw(char)))  # Convert each char to its ASCII value
    })
    
    # Concatenate ASCII values into a single number string
    paste0(ascii_values, collapse = "")
  })
}

uk_firm$numid <- as.numeric(convert_to_unique_numeric(uk_firm$rnum))

uk_firm <- uk_firm %>%
  filter(!(numid == lag(numid,1) & date == lag(date,1)))

library(dplyr)

uk_firm <- uk_firm %>%
  # Filter out rows where uksic is NA or an empty string
  filter(!is.na(uksic), !(uksic == "")) %>%
  
  # Extract and create division (first 2 digits of uksic)
  mutate(division = substr(uksic, 1, 2)) %>%
  group_by(division) %>%
  mutate(nrdivision = cur_group_id()) %>%
  ungroup() %>%
  
  # Extract and create group (first 3 digits of uksic)
  mutate(group = substr(uksic, 1, 3)) %>%
  group_by(group) %>%
  mutate(nrgroup = cur_group_id()) %>%
  ungroup() %>%
  
  # Extract and create class (first 4 digits of uksic)
  mutate(class = substr(uksic, 1, 4)) %>%
  group_by(class) %>%
  mutate(nrclass = cur_group_id()) %>%
  ungroup() %>%
  
  # Extract and create subclass (all 5 digits of uksic)
  mutate(subclass = uksic) %>%
  group_by(subclass) %>%
  mutate(nrsubclass = cur_group_id()) %>%
  ungroup()
setDT(uk_firm)
variables_to_scale <- c("cogs", "adminexp", "interestpaid", "rent", 
                        "rd", "totopren", "hireplant", "intan", "dvt", 
                        "capinv", "sale", "assminlib", "workcap", "otherop", 
                        "retprof", "opprof", "ppegt", "ppent", "xsga")
uk_firm[, (variables_to_scale) := lapply(.SD, function(x) x * 1000), .SDcols = variables_to_scale]

deflator <- fread("UKGDP.csv")
uk_firm <- merge(uk_firm, deflator, by = "date", all.x = TRUE)
uk_firm[, (variables_to_scale) := lapply(.SD, function(x) (x / UKGDP) * 100),
        .SDcols = variables_to_scale]

rm(deflator)

uk_firm <- uk_firm %>%
  filter(!(sale<0) | is.na(sale)) %>% 
  filter(!(cogs>0) | is.na(cogs)) %>%
  filter(!(xsga<0) | is.na(xsga)) %>%
  mutate(s_g = sale/cogs) %>%
  filter(s_g != Inf) %>%
  filter(s_g>0) %>%
  mutate(trim=0) 
