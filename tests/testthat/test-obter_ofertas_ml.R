test_that("gets contents", {
  df <- obter_ofertas_ml(paginas = 1)
  expect_gt(nrow(df), 1)
})

