data(mtcars)

t.test(mtcars$mpg[mtcars$am == 0],
       mtcars$mpg[mtcars$am == 1])

boxplot(mpg~am,data=mtcars)
t.test(mpg~am,data=mtcars)

boxplot(mpg~vs,data=mtcars)
t.test(mpg~vs,data=mtcars)


boxplot(disp ~ am, data = mtcars, notch = T)


# the Swiss dataset could be used for some 
# bonus questions... 


nrow(swiss)
