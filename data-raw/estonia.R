

requireNamespace("raster", quietly = TRUE)

adm1 <- getData("GADM", country = "EST", level = 1, path = "data-raw") %>%
  st_as_sf() %>%
  dplyr::filter(TYPE_1!="Water body") %>%
  st_transform(3301) %>%
  # from 9.5 Mb to 0.3 Mb, 97% reduction
  st_simplify(dTolerance = 100, preserveTopology = FALSE)

est_adm1 <- adm1
usethis::use_data(est_adm1, overwrite = TRUE)
