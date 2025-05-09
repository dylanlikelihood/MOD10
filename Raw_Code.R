# Task 1: EDA

### pair plot

df |> 
  select(
    -family
  ) |> 
  ungroup() |> 
  GGally::ggpairs()


# Summary Statistics:

## Histograms of height variables:

hist(df$father)

hist(df$mother)

hist(df$height)

hist(df$midparent_height)

## max,min avg

df |> 
  select(
    father,
    mother,
    height,
    midparent_height
  ) |> 
  summary()

## Height v sex:

df |> 
  ggplot2::ggplot(
    aes(
      x = sex,
      y = height
    )
  ) +
  geom_boxplot() +
  labs(title = "Male children are taller on average than female children")

## Father height and children height

df |> 
  ggplot2::ggplot(
    aes(
      x = father,
      y = height
    )
  ) +
  geom_point() +
  geom_smooth(method = "glm") +
  labs(title = "Relationship between Father's height and \n Obtained Children Height")


## motherheight and children height

df |> 
  ggplot2::ggplot(
    aes(
      x = mother,
      y = height
    )
  ) +
  geom_point() +
  geom_smooth(method = "glm") +
  labs(title = "Relationship between Mother's height and \n Obtained Children Height")

## Father height and children height

df |> 
  ggplot2::ggplot(
    aes(
      x = father,
      y = height,
      fill = sex
    )
  ) +
  geom_point() +
  geom_smooth(method = "glm") +
  labs(title = "Relationship between Father's height and \n Obtained Children (Male and Female) Height")


## motherheight and children height

df |> 
  ggplot2::ggplot(
    aes(
      x = mother,
      y = height,
      fill = sex
    )
  ) +
  geom_point() +
  geom_smooth(method = "glm") +
  labs(title = "Relationship between Mother's height and \n Obtained Children (Male and Female) Height")


## Midparent height v children height

df |> 
  ggplot2::ggplot(
    aes(
      x = midparent_height,
      y = height,
      fill = sex
    )
  ) +
  geom_point() +
  geom_smooth(method = "glm") +
  labs(title = "Relationship between Midparent Height and \n Obtained Children (Male and Female) Height")


## NBA Potential

df |> 
  ggplot2::ggplot(
    aes(
      x = mba_potential,
      y = height
    )
  ) +
  geom_boxplot() +
  geom_hline(
    yintercept = 66.76,
    color = "red"
  ) +
  labs(
    title = "Shorter parents produce shorter than avergage children and taller parents produce taller than average children",
    subtitle = "Tall is considered 66.75inches or higher"
  )

## NBA Potential by sex

df |> 
  ggplot2::ggplot(
    aes(
      x = mba_potential,
      y = height
    )
  ) +
  geom_boxplot() +
  facet_wrap(~sex) +
  labs(
    title = "Shorter parents produce shorter than avergage children and taller parents produce taller than average children",
    subtitle = "Tall is considered 66.75inches or higher"
  )

## Height Dist of family

df |>
  group_by(
    family
  ) |> 
  filter(
    family %in% c(1:10)
  ) |> 
  ggplot(
    aes(
      x = family,
      y = height
    )
  ) +
  geom_boxplot() + 
  labs(
    x = "Family",
    y = "Height",
    title = "Height Distribution by Family"
  )

# Task 2:
# Compute means for each random effect accross sex

## sex and family

table1 = df |> 
  dplyr::group_by(
    family,
    sex
  ) |> 
  dplyr::summarise(
    mean_height = mean(height, na.rm = TRUE)
  )

## family and nba_potential

table2 = df |> 
  dplyr::group_by(
    family,
    mba_potential
  ) |> 
  dplyr::summarise(
    mean_height = mean(height, na.rm = TRUE)
  )

print(table1)

print(table2)

# Plots for seeing how the intercept can vary

table1 |>
  filter(
    family %in% c(1:10)
  ) |> 
  ggplot(
    aes(x = family,
        y = mean_height
    )
  ) +
  geom_point() +
  labs(
    x = "Family",
    y = "Mean Height",
    title = "Mean Height by Family",
    subtitle = "Scatteredpoints = Intercepts Vary")