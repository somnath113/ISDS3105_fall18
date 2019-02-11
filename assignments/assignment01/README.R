#' ---
#' title: "Assingment 1"
#' author: ""
#' ---


#' Complete the exercises on a new branch of your git repo. Once you are confident that your solutions are correct, merge the branch you created to your master branch. Follow this workflow:
#' 1. Save and commit everything up to now
#' 2. Create a new branch and switch to it `$ git checkout -b solutions` (`$ git checkout [name_of_your_new_branch]` to switch between branches)
#' 3. Go back to your master `$ git checkout master` and merge it with `solutions` using `$ git merge solutions`
#' 4. After you merge, commit to master and push to GitHub
#' use command in terminal 'git remote -v' to find out all the repos 


#' Complete to the following tasks and push the responses to your GitHub:
#' Create a character vector `family` with your family members' names
family = c('som','riya','guntu')
#' Create a vector `birth` with their birth years
birth = c(1984,1987,1990)
#' Create another vector `age` with your family members' ages (calculated using `birth`)
age = 2019 - birth
#' Use `typeof()` to make sure that `family`, `birth`, and `age` are the appropriate type (character, integer/double, integer/double)
typeof(family)
typeof(birth)
typeof(age)
#' Use `names()` to name the elements of `age` with the family members' names from `family`
names(age) = family
#' Use r code to print your name and age (using indexing)
age['som']




#' Respond to the following questions and push the responses to your GitHub:
#' What happens when:
#' You extract using a positive index bigger than the vector length? - We will get 'NA'.
#' You subset by a name that doesn't exist? We get an error.
#' You assign a number to position 20 of the age vector? - we introduce NA to the other position leading upto 20 after existing values.
  

#' Carefully read the documentation for `is.vector()`. If `is.vector(x)` retrieves `TRUE`, does it mean that `x` is an atomic vector? - gives an error as object x is not found
  
  
  
  
  
  