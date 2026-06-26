# 🗺️ Roadmap & Checklist - Ludocard

Este documento define o status atual do desenvolvimento do **Ludocard** (Tauri v2 + React) e as próximas etapas de implementação, com ideias e inspirações retiradas do *GameSave Manager (GSM)* e de boas práticas de UX.

---

## 🟢 1. O que já está feito (Current Status)

O projeto está estruturado como um workspace Rust que contém a biblioteca do Ludosavi no núcleo e a interface do Ludocard via Tauri.

- [x] **Frontend (React + Tailwind v4 + Vite)**: Interface com sidebar, visual moderno, páginas configuradas (Biblioteca, Detalhes, Escanear, Nuvem, Configurações).
- [x] **Tauri Commands (Rust Bridge)**: Comandos em Rust criados para carregar a biblioteca de jogos (`get_games`), realizar backups (`backup_game`), restaurar backups (`restore_game`) e carregar/salvar configurações (`get_settings`/`save_settings`).
- [x] **Segurança e Permissões (Tauri v2)**: Arquivo de capacidades (`default.json`) e arquivo de permissões customizadas (`permissions/ludocard.toml`) configurados para liberar o IPC das funções Rust para o Javascript.
- [x] **Resolução de Conflitos e Compilação**:
  - [x] Correção dos schemas de janela do Tauri v2.
  - [x] Alinhamento de tipos e serialização de campos (ex: `sizeMB` entre o TypeScript e o Serde).
  - [x] Remoção completa do framework antigo (`iced`) e de suas dependências do backend.

---

## 🟡 2. O que falta para fechar a etapa atual (Immediate Tasks)

Ajustes finais para tornar o aplicativo usável como um executável de desktop independente.

- [ ] **Trocar BrowserRouter por HashRouter**: Alterar em `ui/src/main.tsx` para evitar que o roteamento quebre quando o aplicativo carregar a partir dos arquivos locais integrados no `.exe`.
- [ ] **Verificar a Interface**: Testar a navegação de todas as abas e salvar configurações reais para garantir que o backend reflita as alterações nos arquivos `.yaml` locais do Ludosavi.
- [ ] **Geração do Standalone (Ludocard.exe)**: Rodar a compilação final de produção (`tauri build`) para gerar o executável final que roda de forma independente sem o terminal do Node.js.

---

## 🚀 3. Ideias de Recursos & Inspirações do GameSave Manager (GSM)

Para transformar o Ludocard em um utilitário completo de backup, propomos o desenvolvimento das seguintes novas funcionalidades divididas em blocos temáticos:

### Bloco A: Automatização e Segundo Plano (Invisível ao Usuário)
- [ ] **File Watcher (Monitor de Saves)**: Integração com a biblioteca `notify` do Rust. Quando o executável do jogo fechar e houver alterações na pasta de saves, o app faz o backup silencioso e emite uma notificação nativa do Windows.
- [ ] **Executar na Bandeja do Sistema (System Tray)**: Ao clicar no "X", o app minimiza na barra de tarefas (perto do relógio) em vez de fechar, continuando seu trabalho de monitoramento silencioso em segundo plano com consumo quase nulo de memória e CPU.
adicionar uma opção nas configurações para desativar isso e econimzar processamento.
- [ ] **Iniciar com o Windows**: Uma opção na aba de Configurações para adicionar o aplicativo nas chaves de inicialização automática do Registro do Windows (`Run`).
- [ ] **Fixar Save**: Função de fixar um save para ele não ser deletado.

### Bloco B: Facilidades de Armazenamento e Capas
- [x] **Download de Capas Automático**: Conectar com a API da Steam (usando a ID do jogo) ou SteamGridDB para buscar imagens reais de capas verticais para os jogos da biblioteca, substituindo os placeholders estáticos.
- [ ] **Mover Jogos ("Steam Spreader" do GSM)**: Ferramenta para mover jogos instalados da Steam/Epic/GOG para outros discos/pastas do computador, criando Links Simbólicos (Symbolic Links) automaticamente para que os launchers continuem iniciando o jogo sem problemas (útil para limpar espaço em SSDs).

### Bloco C: Recursos Avançados de Backup
- [ ] **Bloqueio de Versão (Pin Backup)**: Permitir "alfinetar" ou "bloquear" um backup específico no histórico (ex: antes de uma escolha importante no jogo), impedindo que ele seja deletado automaticamente quando o limite de retenção for atingido.
- [ ] **Modo Portátil (Portable Mode)**: Opção de salvar todos os backups e arquivos de configuração na própria pasta do executável (permitindo colocar o Ludocard em um pendrive/HD externo e levá-lo com você).
- [ ] **Backup de Configurações do Jogo**: Muitas vezes as configurações gráficas, controles e áudio ficam em pastas diferentes dos saves (ex: arquivos `.ini`/`.cfg` em Documents ou AppData). Ter opções para escanear e salvar esses metadados adicionais.
- [ ] **Perfis de Saves (Modding e Campanhas Paralelas)**: Permitir criar "perfis" diferentes para o mesmo jogo. Útil para separar gameplay com mods de uma campanha limpa (vanilla), ou para jogos de personagem único. O app troca os arquivos da pasta ativa dependendo do perfil selecionado.
- [ ] **Assistente de Conflitos Visual**: Se a nuvem detectar arquivos diferentes entre o PC local e o notebook, exibir uma tela lado a lado comparando as versões com badges claras (ex: *"Este PC (Mais antigo - 10MB)"* vs *"Nuvem (Mais recente - 12MB)"*) para que o usuário decida qual progresso manter.

### Bloco D: Compartilhamento e Recursos Comunitários
- [ ] **Exportação Rápida para Compartilhamento (Share Save)**: Botão para compactar o save atual em um formato próprio (ex: `.ludocard`) ou gerar um link na nuvem para facilitar o envio para amigos ou fóruns.
- [ ] **Repositório Comunitário de "Checkpoints"**: Uma aba integrada para upload e download de saves em marcos históricos de jogos (ex: *"Antes do boss final"*, *"Jogo 100% liberado"*, *"Pular tutorial"*). O app instala o save baixado automaticamente com um clique.
📦 Compressão Brutal (Rust é mestre nisso)
Saves de jogos são, em sua grande maioria, linhas de texto ou dados binários repetitivos. Eles são o tipo de arquivo mais fácil de compactar no mundo.

Usando algoritmos modernos em Rust (como zstd ou lzma), uma pasta de save de 500 MB pode facilmente encolher para 20 MB ou 30 MB em um arquivo .zip altamente compactado.

🛑 Limitação por Checkpoint (Nada de pastas inteiras)
O usuário não vai compartilhar a pasta inteira com 50 versões do jogo dele na aba pública. O app deve exigir que ele selecione um único arquivo de progresso específico (o save slot atual).

Um save individual de Elden Ring tem cerca de 36 MB. O de Cyberpunk 2077 tem uns 6 MB. O de Metro Exodus tem menos de 5 MB. O tamanho médio por upload comunitário cai de gigabytes para míseros megabytes.

⏳ Validade dos Saves (Auto-Delete)
Saves compartilhados na comunidade não precisam ser eternos. Você pode programar o banco de dados para fazer uma faxina automática:

Saves que não receberam nenhum download nos últimos 90 dias são deletados automaticamente do servidor para liberar espaço para novos arquivos.

🛡️ Quota Estrita por Usuário
Para evitar que robôs ou usuários mal-intencionados flodem o seu servidor, você pode criar uma trava simples integrada com a ID do usuário (ou conta do GitHub/Discord se houver login): Cada usuário só pode ter, no máximo, 3 ou 5 saves públicos ativos ao mesmo tempo. Se ele quiser postar um novo, terá que apagar um antigo.

### Bloco E: Ferramentas e UX do Jogador
- [ ] **Atalho Global de Emergência (Quick-Save Manual)**: Atalho customizável (ex: `Ctrl` + `Shift` + `S`) que faz backup instantâneo do jogo em primeiro plano sem precisar de Alt+Tab (um "Save State" nativo para PC).
- [ ] **Notas de Campanha (O "Diário de Bordo")**: Um campo de texto simples dentro do card de cada jogo para anotações rápidas sobre o progresso (ex: *"Parei logo após derrotar o Boss X. Próximo passo: build de mago e explorar área oeste"*).

### Bloco F: Localização e Idiomas
- [ ] **Suporte Multi-idioma**: Tradução completa da interface para múltiplos idiomas (Português, Inglês, Espanhol).
- [ ] **Integração com Fluent**: Conectar com os arquivos de tradução baseados em Fluent (`.ftl`) herdados da biblioteca núcleo do Ludosavi para manter consistência sem redobrar o trabalho de localização.

---

## 🔍 4. Detecção Automática de Jogos de Emuladores (Conceito)

> [!NOTE]
> Para emuladores como Yuzu e Ryujinx, a ideia é permitir que o aplicativo identifique individualmente cada jogo salvo em vez de fazer o backup da pasta inteira do emulador de forma genérica.

### Como funcionaria:
- [ ] **Localização do Emulador**: O aplicativo identifica automaticamente os caminhos padrões ou configurados dos diretórios de dados dos emuladores.
- [ ] **Leitura dos Saves**: Varre o diretório de salvamentos buscando subpastas com os códigos hexadecimais de 16 caracteres (Title IDs), como `01007EF007AD0000` (Zelda: Breath of the Wild).
- [ ] **Mapeamento de Nomes**: Utiliza uma base de dados local ou uma API pública para traduzir o Title ID hexadecimal em um nome amigável para exibição (ex: `01007EF007AD0000` -> `The Legend of Zelda: Breath of the Wild`).
- [ ] **Backup Individual**: Permite ao usuário visualizar e fazer o backup ou restauração de cada jogo separadamente diretamente pela interface do Ludocard.
