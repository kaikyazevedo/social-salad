# Social Salad

**Meu espaço pessoal de organização de trabalho, projetos e clientes.**

Aplicação mobile-first para administrar conteúdo, campanhas, coleções, identidade visual, arquivos e atividades dos projetos que acompanho. O foco é um painel **para meu próprio uso**; não é uma ferramenta de contratos ou de venda.

## Estrutura

- `src/pages/` — telas da aplicação Astro.
- `src/styles/` — identidade visual e responsividade.
- `sql/` — roteiro de banco de dados de um Supabase pessoal, **nunca no projeto THAC**.

## Desenvolvimento

`npm install` e `npm run dev` para rodar localmente. Publicação e banco pessoais serão configurados separadamente.

## Segurança

Não comite `.env`, tokens, chaves secretas ou informações reais de clientes. Área privada e operações com dados reais exigem autenticação, permissões e testes das políticas RLS.

**Status:** estrutura em construção; ainda não é um painel com dados reais.
