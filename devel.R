

library("usethis")
library("devtools")



est_adm1$x <- as.integer(est_adm1$NAME_1 == "Harju")
w <- w_dist_power(st_geometry(est_adm1), alpha = 1)
est_adm1$slx <- w %*% est_adm1$x

years <- tibble(
  year = 2015:2018,
  id = 1
)
est_panel <- est_adm1 %>%
  select(NAME_1) %>%
  mutate(id = 1) %>%
  full_join(years, by = "id") %>%
  mutate(id = NULL,
         x = ifelse((NAME_1=="Harju" & year < 2017) |
                      (NAME_1=="Tartu" & year > 2016), 1L, 0L))

filter(est_panel, x==1)

est_panel <- est_panel %>%
  group_by(year) %>%
  mutate(x_slag = w %*% x)

ggplot(est_panel) +
  facet_wrap(~ year) +
  geom_sf(aes(fill = x_slag), color = "gray90") +
  theme_gray()
