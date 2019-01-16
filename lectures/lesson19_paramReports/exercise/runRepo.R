purrr::map(.x = c("beer_servings", "spirit_servings", "wine_servings"), 
    ~ rmarkdown::render('templateAlcCon.Rmd', 
                        params = list(type = .x), 
                        output_dir = 'report/', 
                        output_file = paste0(.x,'.pdf'))
)
