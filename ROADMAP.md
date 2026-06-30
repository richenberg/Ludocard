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
- [x] **Detecção Inteligente de Jogos Instalados**: O backend agora verifica a presença de arquivos executáveis (`.exe`) nos diretórios de instalação de lojas conhecidas (Steam, Epic, GOG, etc.) para confirmar se o jogo realmente está instalado (evitando falsos positivos de saves remanescentes).
- [x] **Ordenação da Biblioteca (Jogados Recentemente)**: Adicionada a ordenação por "Jogados recentemente", "Tamanho" e "Nome (A-Z)" na barra de ferramentas da biblioteca de jogos, alimentada pela data da última modificação dos saves.
- [x] **Backup Local ou Cloud**: se o cloud backuip estiver ativado, No botão "fazer backup" colocar uma flechinha pra selecionar backup local ou cloud, e deixar o cloud cinza se não estiver configurado
---

## 🟡 2. O que falta para fechar a etapa atual (Immediate Tasks)

Ajustes finais para tornar o aplicativo usável como um executável de desktop independente.

- [x] **Trocar BrowserRouter por HashRouter**: Alterar em `ui/src/main.tsx` para evitar que o roteamento quebre quando o aplicativo carregar a partir dos arquivos locais integrados no `.exe`.
- [x] **Verificar a Interface**: Testar a navegação de todas as abas e salvar configurações reais para garantir que o backend reflita as alterações nos arquivos `.yaml` locais do Ludosavi.
- [x] **Geração do Standalone (Ludocard.exe)**: Rodar a compilação final de produção (`tauri build`) para gerar o executável final que roda de forma independente sem o terminal do Node.js.

---

## 🚀 3. Ideias de Recursos & Inspirações do GameSave Manager (GSM)

Para transformar o Ludocard em um utilitário completo de backup, propomos o desenvolvimento das seguintes novas funcionalidades divididas em blocos temáticos:

### Bloco A: Automatização e Segundo Plano (Invisível ao Usuário)
- [x] **File Watcher (Monitor de Saves)**: Integração com a biblioteca `notify` do Rust. Quando o executável do jogo fechar e houver alterações na pasta de saves, o app faz o backup silencioso e emite uma notificação nativa do Windows.
- [x] **Executar na Bandeja do Sistema (System Tray)**: Ao clicar no "X", o app minimiza na barra de tarefas (perto do relógio) em vez de fechar, continuando seu trabalho de monitoramento silencioso em segundo plano com consumo quase nulo de memória e CPU.
adicionar uma opção nas configurações para desativar isso e econimzar processamento.
- [x] **Iniciar com o Windows**: Uma opção na aba de Configurações para adicionar o aplicativo nas chaves de inicialização automática do Registro do Windows (`Run`).

### Bloco B: Facilidades de Armazenamento e Capas
- [x] **Download de Capas Automático**: Conectar com a API da Steam (usando a ID do jogo) ou SteamGridDB para buscar imagens reais de capas verticais para os jogos da biblioteca, substituindo os placeholders estáticos.
- [ ] **Mover Jogos ("Steam Spreader" do GSM)**: Ferramenta para mover jogos instalados da Steam/Epic/GOG para outros discos/pastas do computador, criando Links Simbólicos (Symbolic Links) automaticamente para que os launchers continuem iniciando o jogo sem problemas (útil para limpar espaço em SSDs).

### Bloco C: Recursos Avançados de Backup
- [x] **Bloqueio de Versão (Pin Backup)**: Permitir "alfinetar" ou "bloquear" um backup específico no histórico (ex: antes de uma escolha importante no jogo), impedindo que ele seja deletado automaticamente quando o limite de retenção for atingido.
- [x] **Modo Portátil (Portable Mode)**: Opção de salvar todos os backups e arquivos de configuração na própria pasta do executável (permitindo colocar o Ludocard em um pendrive/HD externo e levá-lo com você).
- [ ] **Backup de Configurações do Jogo**: Muitas vezes as configurações gráficas, controles e áudio ficam em pastas diferentes dos saves (ex: arquivos `.ini`/`.cfg` em Documents ou AppData). Ter opções para escanear e salvar esses metadados adicionais.
- [ ] **Perfis de Saves (Modding e Campanhas Paralelas)**: Permitir criar "perfis" diferentes para o mesmo jogo. Útil para separar gameplay com mods de uma campanha limpa (vanilla), ou para jogos de personagem único. O app troca os arquivos da pasta ativa dependendo do perfil selecionado.
- [ ] **Assistente de Conflitos Visual**: Se a nuvem detectar arquivos diferentes entre o PC local e o notebook, exibir uma tela lado a lado comparando as versões com badges claras (ex: *"Este PC (Mais antigo - 10MB)"* vs *"Nuvem (Mais recente - 12MB)"*) para que o usuário decida qual progresso manter.

### Bloco D: Compartilhamento e Recursos Comunitários
- [x] **Exportação Rápida para Compartilhamento (Share Save)**: Botão para compactar o save atual em um formato próprio (ex: `.ludocard`) ou gerar um link na nuvem para facilitar o envio para amigos ou fóruns.
- [x] **Repositório Comunitário de "Checkpoints"**: Uma nova aba integrada para upload e download de saves em marcos históricos de jogos (ex: *"Antes do boss final"*, *"Jogo 100% liberado"*, *"Pular tutorial"*). O app instala o save baixado automaticamente com um clique.
📦 Compressão Brutal (Rust é mestre nisso)
Saves de jogos são, em sua grande maioria, linhas de texto ou dados binários repetitivos. Eles são o tipo de arquivo mais fácil de compactar no mundo.

Usando algoritmos modernos em Rust (como zstd ou lzma), uma pasta de save de 500 MB pode facilmente encolher para 20 MB ou 30 MB em um arquivo .zip altamente compactado.

colocar um limite total temporario para nao exeder os 10gb gratis do R2, no futuro podemos tirar esse limite.

🛑 Limitação por Checkpoint (Nada de pastas inteiras)
O usuário não vai compartilhar a pasta inteira com 50 versões do jogo dele na aba pública. O app deve exigir que ele selecione um único arquivo de progresso específico (o save slot atual).

Um save individual de Elden Ring tem cerca de 36 MB. O de Cyberpunk 2077 tem uns 6 MB. O de Metro Exodus tem menos de 5 MB. O tamanho médio por upload comunitário cai de gigabytes para míseros megabytes.

⏳ Validade dos Saves (Auto-Delete)
Saves compartilhados na comunidade não precisam ser eternos. Você pode programar o banco de dados para fazer uma faxina automática:

Saves que não receberam nenhum download nos últimos 90 dias são deletados automaticamente do servidor para liberar espaço para novos arquivos.

🛡️ Quota Estrita por Usuário
Para evitar que robôs ou usuários mal-intencionados flodem o seu servidor, você pode criar uma trava simples integrada com a ID do usuário (ou conta do GitHub/Discord se houver login): Cada usuário só pode ter, no máximo, 3 ou 5 saves públicos ativos ao mesmo tempo. Se ele quiser postar um novo, terá que apagar um antigo.

🚨 Alerta de Segurança Crítico para o App Final (Produção)
Como o Ludocard é um aplicativo de desktop que os usuários vão baixar para rodar em suas máquinas, você nunca deve embutir essas chaves master dentro do código final do app.

Se você colocar seu SECRET_ACCESS_KEY dentro do executável, um usuário mal-intencionado pode abrir o .exe em um descompilador, roubar a sua chave e apagar todos os arquivos do seu Cloudflare.

Como o app final vai fazer o upload/download sem a chave?
O padrão da indústria para softwares de desktop é usar URLs Pré-Assinadas (Presigned URLs):

Quando o usuário do Ludocard quiser subir um save, o seu app faz uma requisição para o seu banco de dados seguro na nuvem (Supabase) pedindo permissão.

O seu backend (que está protegido na nuvem) gera um link temporário especial do Cloudflare que dura apenas 5 minutos e serve para upar só aquele arquivo específico.

O Supabase devolve esse link para o app em Rust.

O app em Rust faz o upload usando esse link temporário.

Dessa forma, o seu aplicativo fica 100% seguro, leve, e nenhuma senha master sua fica exposta no PC dos jogadores! Deu para entender essa lógica de segurança?



### Bloco E: Ferramentas e UX do Jogador
- [ ] **Atalho Global de Emergência (Quick-Save Manual)**: Atalho customizável (ex: `Ctrl` + `Shift` + `S`) que faz backup instantâneo do jogo em primeiro plano sem precisar de Alt+Tab (um "Save State" nativo para PC).
- [ ] **Notas de Campanha (O "Diário de Bordo")**: Um campo de texto simples dentro do card de cada jogo para anotações rápidas sobre o progresso (ex: *"Parei logo após derrotar o Boss X. Próximo passo: build de mago e explorar área oeste"*).

### Bloco F: Localização e Idiomas
- [ ] **Suporte Multi-idioma**: Tradução completa da interface para múltiplos idiomas (Português, Inglês, Espanhol, Russo, Chines simplificado).
- [ ] **Integração com Fluent**: Conectar com os arquivos de tradução baseados em Fluent (`.ftl`) herdados da biblioteca núcleo do Ludosavi para manter consistência sem redobrar o trabalho de localização.

---

- [ ] **Seletor de cloud** No fazer backup colocar uma flechinha pra selecionar backup local ou cloud, e deixar o cloud cinza se não estiver configurado


- [x] **Sistema de compartilhar Presets**
  Uma nova aba e funcionalidade integrada ao card do jogo para gerenciamento de configurações otimizadas (`.ini`, `.cfg` etc.).
  
  1. **O Fluxo de Segurança (O "Seguro-Crash")**:
     - Quando o usuário clica em "Aplicar Configuração Otimizada", o Ludocard automaticamente faz um backup da configuração original atual do usuário.
     - Se o jogo der problema, um botão de "Desfazer e Voltar ao Original" restaura tudo instantaneamente.
  
  2. **Origem dos Arquivos**:
     - *Curadoria Oficial*: Presets oficiais obtidos do PCGamingWiki ou canais de benchmarking.
     - *Crowdsourcing*: Usuários do app podem criar e publicar suas configurações personalizadas. O app captura e anexa o hardware do criador (**CPU, GPU e RAM**) para servir de base.
  
  3. **Sistema de Votação (Opção A) e Segurança**:
     - *Votos de Eficácia (👍/👎)*: Pergunta simples: *"Melhorou a performance?"*. Exibe a porcentagem de aprovação (ex: 92%). Presets com baixa aprovação descem na busca.
     - *Denúncia (🚨 Report)*: Botão discreto para sinalizar presets quebrados ou maliciosos. Se acumular 3 ou mais reports, o preset é ocultado automaticamente da comunidade para moderação.
  
  4. **Fluxo de Criação do Preset pelo Usuário**:
     - O jogador entra no jogo, ajusta os gráficos e controles no menu do jogo e depois o fecha.
     - No Ludocard, ele clica em *"Salvar Configuração Atual como Preset"*.
     - O app detecta automaticamente os arquivos de configuração do jogo (usando o mapeamento do banco do Ludosavi), copia-os localmente e permite que o usuário dê um nome, selecione tags (ex: *Performance*, *Balanced*), adicione uma descrição e confirme suas especificações de hardware (capturadas via backend Rust).
  
  5. **🖥️ Visual e Interações**:
     - **Detalhes de Saves Locais**: Permitir clicar nos cards da timeline local para abrir um modal detalhado, contendo uma área de texto editável para *"Notas de Campanha / Progresso"* salvas localmente no `ludocard.json`.
     - **Save Share Hub**: Cards clicáveis para exibir descrição completa (sem quebras bruscas), tags fixas com tooltips explicando cada uma (ex: `100%`, `DLC1` etc.) e specs de hardware.
     - **Aba de Apoio ao Projeto (`/support`)**: Adicionar um novo item de navegação lateral para uma página dedicada de apoio financeiro, explicando os custos de infraestrutura de nuvem (R2, banco de dados Supabase) e fornecendo botões de apoio via Itch.io e PIX (via QR code ou link).


  6. **🛡️ Medidas de Segurança para o Código Open Source**:
     - *Proteção do Cloud R2 contra abuse*: Validar as cotas de armazenamento na Supabase Edge Function `get-upload-url` antes de emitir o link de upload para o cliente, impedindo uploads fantasmas de usuários mal-intencionados.
     - *Anonymous Auth*: Utilizar autenticação anônima do Supabase para assinar os tokens JWT do cliente e evitar falsificação do `user_uuid` no controle de cotas de upload.
     - *Ciclo de Vida do R2*: Configurar regras de exclusão automática no Cloudflare R2 para limpar arquivos abandonados.


      🟥 Preset Potato Mode (Para PCs Ultra-Antigos): Reduz tudo ao mínimo do mínimo, desativa sombras complexas e otimiza a memória para rodar em qualquer máquina.

      Informações Úteis por Preset: Cada perfil mostraria uma descrição curta do autor: "Ganha cerca de 15% de FPS na cidade. Testado na versão 1.63 do jogo."

      Botão "Injetar Configuração": Um clique e o app substitui os arquivos locais.

## 🔍 5. Detecção Automática de Jogos de Emuladores (Conceito)

> [!NOTE]
> A ideia é permitir que o aplicativo identifique e gerencie individualmente o save de cada jogo emulado (Yuzu, Ryujinx, Dolphin, RetroArch, etc.) em vez de fazer o backup genérico da pasta inteira do emulador.

### Como funcionará a arquitetura:
- [x] **Fluxo de Adição**: O usuário aponta para a pasta do emulador (ou seleciona o executável do emulador). O app identifica o emulador pelo nome do executável (ex: `yuzu.exe`, `Ryujinx.exe`, `dolphin.exe`, `pcsx2.exe`, `retroarch.exe`, `mgba.exe`, `citra-qt.exe`).
- [x] **Localização Inteligente de Saves**:
  - Tenta localizar a pasta de saves na pasta do emulador (caso esteja em Modo Portátil, ex: pasta `user/nand/` no Yuzu ou `portable/bis/` no Ryujinx).
  - Caso contrário, usa os caminhos padrão do sistema de arquivos (`%APPDATA%`, `%USERPROFILE%/Documents`, etc.).
- [x] **Diferenciação por Tipo de Save**:
  - **Sistemas por Title ID (Switch, 3DS, Wii)**: Varre subpastas buscando IDs hexadecimais de 16 caracteres (ex: `01007ef00011e000`). Converte esses IDs para nomes amigáveis usando um dicionário local de jogos populares ou uma API de fallback.
  - **Sistemas por Nome de ROM (GBA, PS2, RetroArch)**: Lê os arquivos de save diretamente (ex: `Pokemon FireRed.sav`, `Silent Hill 2.ps2`). O próprio nome do arquivo (sem extensão) é usado como o nome amigável do jogo.
- [x] **Integração via Custom Games (Ludosavi)**:
  - Cada jogo detectado é cadastrado dinamicamente como um `CustomGame` no arquivo `config.yaml` do Ludosavi, sob a nomenclatura `[Emulador] Nome do Jogo` (ex: `[Yuzu] The Legend of Zelda: Tears of the Kingdom`).
  - Permite que o Ludocard use a mesma engine robusta de backup, restauração, cloud sync, notas e monitoramento para os jogos emulados.
- [x] **Badges Temáticas Premium**:
  - Mantém a classificação de plataforma como `"Emulador"` para agrupamento e filtros de biblioteca.
  - Adiciona o campo `emulator` (ex: `"Yuzu"`, `"Ryujinx"`, `"Dolphin"`) ao `FrontendGame`.
  - Exibe badges customizadas com as cores características de cada marca (ex: 🔴 Yuzu, 🔵 Ryujinx, 🐬 Dolphin, 🟣 mGBA, 🎮 RetroArch) na interface.

## 👑 4. Área Administrativa (Painel Admin)

- [ ] **Painel de Controle Admin**: Uma tela ou modal oculto/protegido por senha nas configurações para gerenciamento da infraestrutura.
- [ ] **Gerenciamento de Conteúdo**: Listagem e opção de deletar diretamente do Supabase/R2 saves e presets que estejam corrompidos, ofensivos ou com erros.
- [ ] **Monitoramento de Quota R2**: Exibição da cota e espaço restante no Cloudflare R2 (gratuito de 10 GB) com métricas de uso em tempo real.
- [ ] **Histórico e Logs**: Rastreamento de uploads suspeitos e ações para banimento de UUIDs abusivos.
