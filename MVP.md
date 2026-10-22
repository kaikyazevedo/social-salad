# Social Salad — MVP v1 (branch de implementação)

**Produto pessoal**, independente de THAC. Mantenha `/demo` como referência; o MVP está em `/app`.

## Escopo v1
- Email + senha via Supabase Auth; nenhuma chave secreta no browser.
- Dashboard com totais reais; criação, edição e exclusão de marcas, conteúdos, tarefas e campanhas.
- Filtros por módulo, marca e status; layout mobile-first.
- Duas tabelas com RLS e proteção da relação marca/item.
- Estados vazios em vez de dados inventados.

## Ativação (ainda não executada)
1. Criar projeto Supabase na **organização pessoal salad**. Confirmar organização/custos no painel.
2. Aplicar `supabase/migrations/20261021_social_salad_mvp.sql` nesse projeto novo.
3. No Supabase Auth, criar/autorizar somente seu usuário; configurar Site URL e redirects. Não abrir cadastro público na versão inicial.
4. Na Vercel pessoal, conectar **GitHub Login Connection** à conta kaikyazevedo. Importar `social-salad`.
5. Configurar variáveis de build na Vercel: `PUBLIC_SUPABASE_URL` e `PUBLIC_SUPABASE_PUBLISHABLE_KEY` (publishable/anon, nunca service_role).
6. Fazer build e testar CRUD/logoff em `/app` usando usuário real; confirmar que nenhum usuário tem acesso aos dados de outro.

**Não é seguro inserir dados reais antes de ativar banco e validar políticas.**
