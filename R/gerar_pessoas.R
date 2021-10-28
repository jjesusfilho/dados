#' Gera dados aleatórios sobre pessoas físicas do 4devs.
#'
#' @param n Número de observações. Máximo 30 pessoas.
#'
#' @return data.frame
#' @export
#'
#' @examples
#' df <- gerar_pessoas(n = 5)
gerar_pessoas <- function(n = 5){


  url <- "https://www.4devs.com.br/ferramentas_online.php"


  body <- list(acao = "gerar_pessoa", sexo = "I", pontuacao = "S", idade = "0",
               cep_estado = "", txt_qtde = n, cep_cidade = "Selecione o estado!")


  httr::POST(url, body = body, encode = "form") |>
    httr::content("text") |>
    jsonlite::fromJSON()

}
