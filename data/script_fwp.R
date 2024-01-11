library(tidyverse)
library(stringi)

x <- read_csv("csv/interview.csv")
y <- read_csv("csv/interviewee_crosswalk.csv")
z <- read_csv("csv/interviewee.csv")

out <- x |>
  inner_join(slice_head(group_by(y, id), n = 1), by = "id") |>
  inner_join(slice_head(group_by(z, interviewee), n = 1), by = "interviewee") |>
  mutate(state = stri_replace_all(state, "_", fixed = " ")) |>
  mutate(state = stri_trans_tolower(state)) |>
  mutate(race = if_else(race == "White", "white", race)) |>
  mutate(race = if_else(race == "Black", "black", race)) |>
  mutate(race = if_else(race %in% c("black", "white"), "", race)) |>
  filter(!is.na(state)) |>
  filter(!is.na(race)) |>
  filter(!is.na(gender))  