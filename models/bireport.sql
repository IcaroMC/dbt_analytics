{{
    config(
        materialized = 'table',
        /*Dica: caso precise fazer um lock ou qualquer tratamento antes nos dados ou na tabela*/
        pre_hook =['
            begin;
            lock table {{target.schema}}.bireport
        ']
        post_hook = ['
            commit;
            grant usage on schema {{target.schema}} to group biusers;
            grant select on table {{target.schema}}.bireport to group biusers;

        ']
    )
}}


select
    *
from
    {{ref('joins')}}