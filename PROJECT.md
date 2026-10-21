# SOCIAL SALAD — VISÃO DO PRODUTO

## Objetivo
Um espaço PESSOAL de trabalho para Kaiky organizar clientes, marcas, projetos e a sua rotina de social media. Não é um SaaS comercial, loja nem ferramenta para fechar contratos.

## Prioridade
1. Painel privado do proprietário (Kaiky).
2. Acesso por marca/cliente e troca rápida de contexto.
3. Planejamento de conteúdo (calendário, ideias, roteiros, status e entregas).
4. Coleções e campanhas (conceito, fases, materiais).
5. Identidade visual (paleta, fontes, referências, biblioteca).
6. Projetos, tarefas, arquivos e histórico.
7. Acesso opcional por cliente no futuro, apenas a material liberado.

## Design
Mobile-first de verdade: desenvolvimento para 360–430 px, depois tablet e desktop.
Visual editorial: preto, grade pontilhada, magenta, amarelo ácido, azul elétrico, títulos sans pesados, serif itálico, linhas finas e linguagem humana. Não usar template corporativo.
A página pública pode existir, mas a finalidade é organização e operação interna.

## Fluxo de desenvolvimento
GitHub pessoal como fonte do código. Supabase pessoal e Vercel pessoal/alternativa, NUNCA usar os recursos da THAC.
Primeiro preview navegável com dados fictícios. Depois autenticação real e regras RLS. Só inserir dados reais após proteção testada.
Evitar dependências desnecessárias, não expor tokens e não modificar produção sem validar build.

## Fase atual
Fase 1: código inicial de Home + demonstração mobile-first. Sem login ou banco de dados real. Não use esta versão para guardar informações privadas.
