test_that("gets contents", {

  df <- gerar_pessoas(n = 5)
  expect_equal(nrow(df), 5)
})
