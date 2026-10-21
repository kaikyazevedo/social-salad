# Social Salad

Um espaço **pessoal e mobile-first** para organizar o trabalho com marcas e clientes: planejamento de conteúdo, coleções/campanhas, identidade visual e projetos.

## Iniciar
1. Instale Node.js 20.19+.
2. Rode `npm install`.
3. Rode `npm run dev`.
4. Abra `http://localhost:4321`.

## Rotas
- `/`: Home de apresentação do Social Salad.
- `/demo`: demonstração navegável do painel, com **dados 100% fictícios**.

**O painel é uma demonstração, não um sistema autenticado**. Não insira dados privados de clientes.

## Próxima etapa
Criar Supabase pessoal (separado da THAC), implementar acesso exclusivo do proprietário, CRUD de clientes e planejamento, upload privado e políticas RLS. Hospedagem independente e validação de segurança antes de usar informações reais.

## Código e segredos
Nunca versionar chaves sensíveis ou variáveis .env. Projeto pessoal separado de THAC Production OS.
