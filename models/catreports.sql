-- Tipos de configurações: 
    -- ephemeral: dados temporarios em tempo de execução do modelo
    -- table: cria uma tabela no banco de dados
    -- incremental
{{
   config(
        materialized = 'incremental',
        unique_key = 'category_id'
   )
}}

-- Esse retorno é padrão para criação de view no banco
select * from {{source('sources', 'categories')}}