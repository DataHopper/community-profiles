#Tom Hopper Homework 1, Part 2 - WALKTHROUGH OF ALL EXAMPLES IN CHAPTER 3

# Installing and loading the tidyverse package:

library(tidyverse)
library(maps)

# Examining the mpg data frame
mpg

# Creating a simple scatter plot of engine displacement and highway mpg. Hello world!
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# Running code from exercise 3.2.4.1. The code does not produce anything, because not 
# enough information was supplied
ggplot(data = mpg)

# First plot with aesthetics defined, varying color of points by a variable:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Now varying size of points by a variable:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# playing with transparency settings:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
#and shapes of points:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# introducing colors outside of aesthetic settings:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# code from Exercise 3.3.1.1 - doesn't color the points blue because the color argument 
# was made within the aesthetics parentheses, making ggplot think that "blue" is a variable
# upon which to vary color.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# fixed code:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Intro to facets using facet_wrap
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#  using facet_grid
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Exercise 3.5.1.2 - This plot shows where there is data between the drv and cyl variables, 
# and where there would be empty plots in a facet_grid with these two variables.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# Exercise 3.5.1.3 - these plots use "." to create 1-row or 1-column facet_grids
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# Exercise 3.5.1.4 - Shows the benefits of using faceting instead of color codes - 
# You can quickly pick out trends by class that might not be as clear in one plot that 
# varies class by color.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# Introduction to smoothing lines and geom objects, first plot is the point geom, 
# second is the smoothed line with standard error geom
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# Smoothed lines, one for each drive type and line type is varied by drive type as well:
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# Variations on smoothed line types: 1 smoothed line for dataset, separate smoothed lines 
# by drive type, and separate + color-coded smoothed lines by drive type
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# Showing data points and a smoothed line together:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# same plot, different code:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# highlighting the importance of where to include the aesthetic arguments to make settings 
# for individual plot layers:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

# and different data can be used for generating different layers, such as in this example, 
# where the smoothed line uses a subset of the full dataset:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Exercise 3.6.1.2 - Answered in the assignment, generates a scatterplot with a smoothed 
# line without the standard error for each drive type, color-coded.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# Will these two charts look different? No, because the local settings for the geom_point 
# and geom_smooth layers in the second set of code are the same as the global settings in 
# the ggplot layer in the first snippet.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#Basic bar chart showing quantities
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

#Creating a bar chart using stat_count
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

#Demonstrating overriding the default geom of a stat function
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

# demonstrating overriding the default mapping of a stat function
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

#drawing attention to the statistical distribution
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#Exercise 3.7.1.5 - Showing the importance of setting group for a proportional value 
# column chart. These two charts fail to show proportion.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

# demonstrating using color v. using fill to set colors
# color creates outline color
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))
#fill creates fill colors
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# showing ways to use color to create stacked bar charts
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# Highlighting position = "identity" by using transparency and no-fill
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# demonstrating position = "fill" to create a 100% stacked bar chart
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# showing how position = "dodge" creates clustered bar charts
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Demonstrating the value of "jitter" for scatterplots with overplotting problems
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#Exercise 3.8.1 - showing a plot with overplotting
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

# demonstrating how to use coord_flip and plot coordinate systems to flip axes:
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

#Using coord_quickmap() to set proper aspect ratio for spatial data
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

# Using coord_polar() to create a Coxcomb chart
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

#Exercise 3.9.1.4 - demonstrates an abline and a fixed_coord application
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

