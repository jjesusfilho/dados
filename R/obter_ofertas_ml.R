#' Obter ofertas mais recentes do Mercado Livre
#'
#' @param paginas Número de páginas
#'
#' @return Tibble
#' @export
#'
#' @examples
#' df <- obter_ofertas_ml(paginas = 1)
obter_ofertas_ml <- function(paginas = 1){


  url <-"https://www.mercadolivre.com.br/ofertas?page="

  n <- 1:paginas

h1 <- httr::add_headers(`User-Agent`  = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0) Gecko/20100101 Firefox/91.0",
`Accept` = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
`Accept-Language` = "en-US,en;q=0.5",
`Connection` =  "keep-alive",
`Upgrade-Insecure-Requests` = "1",
`Sec-Fetch-Dest` =  "document",
`Sec-Fetch-Mode` = "navigate",
`Sec-Fetch-Site` =  "none",
`Sec-Fetch-User` =  "?1")


  purrr::map_dfr(n, purrr::possibly(~{

    url2 <- paste0(url, .x)

    conteudo <- httr::GET(url2, h1) |>
      httr::content()

    produto <- conteudo |>
      xml2::xml_find_all("//p[@class='promotion-item__title']") |>
      xml2::xml_text()

    preco <- conteudo |>
      xml2::xml_find_all("//span[@class='promotion-item__price']/span") |>
      xml2::xml_text()

    # centavos <- conteudo %>%
    #   xml2::xml_find_all("//span[@class='promotion-item__price']/sup") %>%
    #   xml2::xml_text() %>%
    #   stringr::str_extract("\\d.+") %>%
    #   stringr::str_remove_all("\\.") %>%
    #   stringr::str_replace(",",".") %>%
    #   as.numeric()


    tibble::tibble(produto, preco)


  },NULL))
}
