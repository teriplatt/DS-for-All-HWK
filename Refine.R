library(tidyverse)

# I am reading in my data file
refine <- read_csv("refine_original.csv")

# turn everything lower case
refine$company <- tolower(refine$company)

# convert the remaining cases
refine$company <- case_when(
  refine$company == "phillips"~"philips",
  refine$company == "phllips"~"philips",
  refine$company == "phillps" ~ "philips",
  refine$company == "philips" ~ "philips",
  refine$company == "akz0" ~ "akzo",
  refine$company == "ak zo" ~ "akzo",
  refine$company == "fillips" ~ "philips",
  refine$company == "phlips" ~ "philips",
  refine$company == "unilver" ~ "unilever",
  refine$company == "akzo" ~ "akzo",
  refine$company == "van houten" ~ "van houten",
  refine$company == "unilever" ~ "unilever"
)

#separate product code and product number
refine <- refine %>%
  separate("Product code / number", into = c("product_code", "product_number")) 

#add product categories column
refine$categories <- case_when(
  refine$product_code == "p" ~ "Smartphone",
  refine$product_code == "v" ~ "TV",
  refine$product_code == "x" ~ "Laptop",
  refine$product_code == "q" ~ "Tablet"
)

#add full address for geocoding
refine <- unite(refine,"full_address", c("address", "city", "country"), sep = ",")

#creating dummy variables
refine <- mutate(refine,
                 company_philips = as.numeric(company == "philips"),
                 company_akzo = as.numeric(company == "akzo"),
                 company_van_houten = as.numeric(company == "van houten"),
                 company_unilever = as.numeric(company == "unilever"),
                 product_smartphone = as.numeric(categories == "Smartphone"),
                 product_tv = as.numeric(categories == "TV"),
                 product_tablet = as.numeric(categories == "Tablet"),
                 product_laptop = as.numeric(categories == "Laptop"))


