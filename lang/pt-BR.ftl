ludusavi = Ludusavi
language = Idioma
game-name = Nome
total-games = Jogos
file-size = Tamanho
file-location = Localização
overall = Geral
status = Status
cli-unrecognized-games = Sem informações para estes jogos:
cli-unable-to-request-confirmation = Não foi possível solicitar confirmação.
    .winpty-workaround = Se você estiver usando um emulador Bash (como Git Bash), tente executar a winpty.
cli-backup-id-with-multiple-games = Não é possível especificar a ID do backup ao restaurar vários jogos.
cli-invalid-backup-id = ID do backup inválido.
badge-failed = FALHOU
badge-duplicates = DUPLICADOS
badge-duplicated = DUPLICADO
badge-ignored = IGNORADO
badge-redirected-from = DE: { $path }
badge-redirecting-to = PARA: { $path }
some-entries-failed = Algumas entradas não conseguiram processar; procure por { badge-failed } na saída para mais detalhes. Verifique se você pode acessar esses arquivos ou se os caminhos deles são muito longos.
cli-game-line-item-redirected = Redirecionado de: { $path }
cli-game-line-item-redirecting = Redirecionando para: { $path }
button-backup = Fazer backup
button-preview = Visualizar
button-restore = Restaurar
button-nav-backup = MODO DE BACKUP
button-nav-restore = MODO DE RESTAURAÇÃO
button-nav-custom-games = JOGOS PERSONALIZADOS
button-nav-other = OUTRO
button-add-game = Adicionar jogo
button-continue = Continuar
button-cancel = Cancelar
button-cancelling = Cancelamento...
button-okay = Ok
button-select-all = Selecionar tudo
button-deselect-all = Desmarcar tudo
button-enable-all = Ativar tudo
button-disable-all = Desativar tudo
button-customize = Personalizar
button-exit = Sair
button-comment = Comentário
button-lock = Travar
button-unlock = Destravar
# This opens a download page.
button-get-app = Obter { $app }
button-validate = Validar
button-override-manifest = Sobrescrever manifesto
button-extend-manifest = Estender manifesto
button-sort = Classificar
button-download = Download
button-upload = Upload
button-ignore = Ignorar
no-roots-are-configured = Adicione algumas raízes para armazenar ainda mais dados.
config-is-invalid = Erro: O arquivo de configuração é inválido.
manifest-is-invalid = Erro: O arquivo de manifesto é inválido.
manifest-cannot-be-updated = Erro: Não foi possível verificar se há uma atualização no manifesto. Sua conexão com a Internet está inativa?
cannot-prepare-backup-target = Erro: Não é possível preparar o destino do backup (criando ou esvaziando a pasta). Se você tiver a pasta aberta no seu navegador de arquivos, tente fechá-la: { $path }
restoration-source-is-invalid = Erro: A fonte de restauração é inválida (ou não existe ou não é um diretório). Por favor, verifique o local: { $path }
registry-issue = Erro: Algumas entradas de registro foram ignoradas.
unable-to-browse-file-system = Erro: Não é possível navegar no seu sistema.
unable-to-open-directory = Erro: Não é possível abrir o diretório:
unable-to-open-url = Erro: Não foi possível abrir a URL:
unable-to-configure-cloud = Não foi possível configurar a nuvem.
unable-to-synchronize-with-cloud = Não foi possível sincronizar com a nuvem.
cloud-synchronize-conflict = Seus backups locais e da nuvem estão em conflito. Execute um upload ou download para resolver isso.
command-unlaunched = Comando não iniciou: { $command }
command-terminated = Comando encerrado abruptamente: { $command }
command-failed = O comando falhou com o código { $code }: { $command }
processed-games =
    { $total-games } { $total-games ->
        [one] jogo
       *[other] jogos
    }
processed-games-subset =
    { $processed-games } de { $total-games } { $total-games ->
        [one] jogo
       *[other] jogos
    }
processed-size-subset = { $processed-size } de { $total-size }
field-backup-target = Fazer backup para:
field-restore-source = Restaurar de:
field-custom-files = Caminhos:
field-custom-registry = Registro:
field-sort = Organizar:
field-redirect-source =
    .placeholder = Fonte (local original)
field-redirect-target =
    .placeholder = Alvo (novo local)
field-roots = Raiz:
field-backup-excluded-items = Exclusões do backup:
field-redirects = Redirecionar:
# This appears next to the number of full backups that you'd like to keep.
# A full backup includes all save files for a game.
field-retention-full = Todos:
# This appears next to the number of differential backups that you'd like to keep.
# A differential backup includes only the files that have changed since the last full backup.
field-retention-differential = Diferencial:
field-backup-format = Formato:
field-backup-compression = Compressão:
# The compression level determines how much compresison we perform.
field-backup-compression-level = Nível:
label-manifest = Manifesto
# This shows the time when we checked for an update to the manifest.
label-checked = Verificado
# This shows the time when we found an update to the manifest.
label-updated = Atualizado
label-new = Novo
label-removed = Removido
label-comment = Comentário
label-unchanged = Inalterada
label-backup = Backup
label-scan = Escanear
label-filter = Filtro
label-unique = Único
label-complete = Concluído
label-partial = Parcial
label-enabled = Ativado
label-disabled = Desativado
# https://en.wikipedia.org/wiki/Thread_(computing)
label-threads = Tópicos
label-cloud = Nuvem
# A "remote" is what Rclone calls cloud systems like Google Drive.
label-remote = Remoto
label-remote-name = Nome remoto
label-folder = Pasta
# An executable file
label-executable = Executável
# Options given to a command line program
label-arguments = Argumentos
label-url = URL
# https://en.wikipedia.org/wiki/Host_(network)
label-host = Hospedeiro
# https://en.wikipedia.org/wiki/Port_(computer_networking)
label-port = Porta
label-username = Nome de usuário
label-password = Senha
# This is a specific website or service that provides some cloud functionality.
# For example, Nextcloud and Owncloud are providers of WebDAV services.
label-provider = Provedor
label-custom = Personalizado
label-none = Nenhum
label-change-count = Mudanças: { $total }
label-unscanned = Não verificado
# This refers to a local file on the computer
label-file = Arquivo
label-game = Jogo
# Aliases are alternative titles for the same game.
label-alias = Apelido
label-original-name = Nome original
# Which manifest a game's data came from
label-source = Fonte
# This refers to the main Ludusavi manifest: https://github.com/mtkennerly/ludusavi-manifest
label-primary-manifest = Manifesto primário
# This refers to how we integrate a custom game with the manifest data.
label-integration = Integração
# This is a folder name where a specific game is installed
label-installed-name = Nome Instalado
store-ea = EA
store-epic = Epic
store-gog = GOG
store-gog-galaxy = GOG Galaxy
store-heroic = Heroic
store-legendary = Legendary
store-lutris = Lutris
store-microsoft = Microsoft
store-origin = Origin
store-prime = Prime Gaming
store-steam = Steam
store-uplay = Uplay
store-other-home = Pasta padrão
# This would be a folder acting as a virtual C: drive, created by Wine.
store-other-wine = Prefixo Wine
# This would be a folder with typical Windows system folders,
# like "Program Files (x86)" and "Users".
store-other-windows = Drive do Windows
# This would be a folder with typical Linux system folders,
# like "home" and "opt".
store-other-linux = Drive do Linux
# This would be a folder with typical Mac system folders,
# like "Applications" and "Users".
store-other-mac = Drive do Mac
store-other = Outro
backup-format-simple = Simples
backup-format-zip = Zip
compression-none = Nenhum
# "Deflate" is a proper noun: https://en.wikipedia.org/wiki/Deflate
compression-deflate = Deflate
compression-bzip2 = Bzip2
compression-zstd = Zstd
theme = Tema
theme-light = Claro
theme-dark = Escuro
redirect-bidirectional = Bidirecional
reverse-redirects-when-restoring = Reverter sequência de redirecionamentos durante restauração
show-disabled-games = Mostrar jogos desativados
show-unchanged-games = Mostrar jogos inalterados
show-unscanned-games = Mostrar jogos não escaneados
override-max-threads = Substituir o número máximo de threads
synchronize-automatically = Sincronizar automaticamente
prefer-alias-display = Exibir apelido ao invés do nome original
skip-unconstructive-backups = Pular backup quando dados serão removidos ao invés de adicionados ou atualizados
explanation-for-exclude-store-screenshots = Nos backups, exclui capturas de tela específicas de armazenamento
explanation-for-exclude-cloud-games = Não faça backup de jogos com suporte à nuvem nessas plataformas
consider-doing-a-preview =
    Se você ainda não fez, considere fazer uma pré-visualização primeiro, então
    não há surpresas.
confirm-backup =
    Tem certeza que deseja prosseguir com o backup? { $path-action ->
        [merge] Novos dados salvos serão mesclados na pasta de destino:
       *[create] A pasta de destino será criada:
    }
confirm-restore =
    Tem certeza que deseja prosseguir com a restauração?
    Isto irá sobrescrever qualquer arquivo atual com os backups aqui:
confirm-cloud-upload =
    Você quer substituir seus arquivos na nuvem por seus arquivos locais?
    Seus arquivos da nuvem ({ $cloud-path }) se tornarão uma cópia exata de seus arquivos locais ({ $local-path }).
    Arquivos na nuvem serão atualizados ou excluídos conforme necessário.
confirm-cloud-download =
    Deseja substituir seus arquivos locais por seus arquivos na nuvem?
    Seus arquivos locais ({ $local-path }) se tornará uma cópia exata dos seus arquivos de nuvem ({ $cloud-path }).
    Os arquivos locais serão atualizados ou excluídos conforme necessário.
confirm-add-missing-roots = Adicionar estas origens?
no-missing-roots = Nenhuma origem adicional encontrada.
loading = Carregando...
preparing-backup-target = Preparando o diretório de backup...
updating-manifest = Atualizando manifesto...
no-cloud-changes = Não há alterações para sincronizar
backups-are-valid = Seus backups são válidos.
backups-are-invalid =
    Os backups destes jogos parecem inválidos.
    Você deseja criar novos backups completos para esses jogos?
saves-found = Dados salvos encontrados.
no-saves-found = Não foram encontrados dados salvos.
# This is tacked on to form something like "Back up (no confirmation)",
# meaning we would perform an action without asking the user if they're sure.
suffix-no-confirmation = sem confirmação
# This is shown when a setting will only take effect after closing and reopening Ludusavi.
suffix-restart-required = é necessário reiniciar
prefix-error = Erro: { $message }
prefix-warning = Aviso: { $message }
cloud-app-unavailable = Backups na nuvem estão desativados porque { $app } não está disponível.
cloud-not-configured = Backups na nuvem estão desativados porque nenhum sistema na nuvem está configurado.
cloud-path-invalid = Backups na nuvem estão desativados porque o caminho de backup é inválido.
game-is-unrecognized = Este jogo não foi reconhecido pelo Ludusavi.
game-has-nothing-to-restore = Este jogo não tem um backup para restauração.
launch-game-after-error = Iniciar o jogo de qualquer forma?
game-did-not-launch = Jogo falhou ao iniciar.
backup-is-newer-than-current-data = O backup existente é mais recente que os dados atuais.
backup-is-older-than-current-data = O backup existe é mais antigo que os dados atuais.
back-up-specific-game =
    .confirm = Fazer backup dos dados de { $game }?
    .failed = Falha ao fazer backup dos dados de { $game }
restore-specific-game =
    .confirm = Restaurar dados salvos de { $game }?
    .failed = Falha ao restaurar dados de { $game }
new-version-check = Verificar por atualizações do aplicativo automaticamente
new-version-available = Uma atualização do aplicativo está disponível: { $version }. Gostaria de ver as notas de lançamento?
custom-game-will-override = Esse jogo personalizado substitui uma entrada de manifesto
custom-game-will-extend = Este jogo personalizado estende uma entrada de manifesto
operation-will-only-include-listed-games = Isso processará apenas os jogos que estão listados no momento

ludocard-library = Biblioteca
ludocard-scan-and-add = Escanear & Adicionar
ludocard-cloud-and-sync = Nuvem & Sincronização
ludocard-save-share-hub = Save Share HUB
ludocard-preset-share-hub = Preset Share HUB
ludocard-settings = Configurações
ludocard-support-project = Apoiar o Projeto
ludocard-library-status = Status da biblioteca
ludocard-games = Jogos
ludocard-language = Idioma
ludocard-language-desc = Idioma da interface.
ludocard-sidebar-subtitle = Backup de saves
ludocard-navigation = Navegação
ludocard-stored-saves = Saves armazenados
ludocard-pending-saves = Pendentes
ludocard-downloading-covers = Baixando capas...
ludocard-settings-desc = Preferências e comportamento do aplicativo
ludocard-dashboard-desc = Gerencie e proteja os saves dos seus jogos

ludocard-file-watcher = Monitor de Saves (File Watcher)
ludocard-file-watcher-desc = Monitora alterações nos saves e faz backup automático quando o jogo fechar.
ludocard-start-with-windows = Iniciar com o Windows
ludocard-start-with-windows-desc = Abre minimizado na bandeja do sistema ao ligar o PC.
ludocard-system-tray = Executar na Bandeja (System Tray)
ludocard-system-tray-desc = Minimiza o aplicativo perto do relógio ao invés de fechar, mantendo o monitoramento em segundo plano.
ludocard-portable = Modo Portátil (Portable Mode)
ludocard-portable-desc = Salva todas as configurações, manifestos e backups na pasta do executável (ideal para pendrives).
ludocard-theme = Tema
ludocard-theme-desc = Aparência da interface do aplicativo.
ludocard-theme-dark = Escuro
ludocard-theme-light = Claro
ludocard-theme-system = Sistema
ludocard-backup-dir = Diretório de Backup
ludocard-backup-dir-desc = Onde os saves dos seus jogos serão guardados localmente.

ludocard-rclone-path = Caminho do executável Rclone
ludocard-rclone-path-desc = Caminho para o executável rclone usado no envio para nuvem.
ludocard-cloud-folder = Pasta Remota na Nuvem
ludocard-cloud-folder-desc = Nome da pasta remota para sincronizar os arquivos.
ludocard-rclone-args = Argumentos extras do Rclone
ludocard-rclone-args-desc = Comandos e flags opcionais passados diretamente ao rclone.
ludocard-supabase-url = URL do Supabase (Repositório Comunitário)
ludocard-supabase-url-desc = URL da API do seu projeto Supabase para a aba de comunidade.
ludocard-supabase-key = Anon Key do Supabase
ludocard-supabase-key-desc = Chave pública (anon) usada para autenticação anônima nas tabelas.
ludocard-btn-save-settings = Salvar Configurações

ludocard-tab-general = Geral
ludocard-tab-schedule = Agendamento
ludocard-tab-notifications = Notificações
ludocard-general-preferences = Preferências gerais
ludocard-general-preferences-desc = Caminhos e comportamento básico do aplicativo.

ludocard-status-synchronized = Sincronizado
ludocard-status-pending = Backup pendente
ludocard-status-none = Sem backup
ludocard-backup = Backup
ludocard-restore = Restaurar
ludocard-current-save = Save Ativo
ludocard-last-backup = Último Backup
ludocard-manual-backup = Backup Manual
ludocard-loading-library = Carregando biblioteca de jogos...
ludocard-monitored-games = Jogos Monitorados
ludocard-cloud-synced = Sincronizados na Nuvem
ludocard-pending-saves-plural = Backups Pendentes
ludocard-search-games = Buscar jogos...
ludocard-clear-search = Limpar busca
ludocard-select-all = Selecionar todos
ludocard-platform = Plataforma
ludocard-all-platforms = Todas as Plataformas
ludocard-sort-by = Ordenar por
ludocard-sort-name = Nome (A-Z)
ludocard-sort-recent = Jogado recentemente
ludocard-sort-size = Tamanho do save
ludocard-installed = Instalado
ludocard-pending = Pendente
ludocard-grid-view = Visualização em grade
ludocard-list-view = Visualização em lista
ludocard-showing = Exibindo
ludocard-of = de
ludocard-game = jogo
ludocard-games-plural = jogos
ludocard-no-games-found = Nenhum jogo encontrado
ludocard-adjust-filters-desc = Ajuste os filtros ou varra suas pastas para adicionar novos jogos.
ludocard-starting-backup-for = Iniciando backup para
ludocard-backup-completed-for = Backup de
ludocard-completed = concluído!
ludocard-completed-fem = concluída!
ludocard-backup-failed-for = Falha no backup de
ludocard-restoring-backup-for = Restaurando backup de
ludocard-restore-completed-for = Restauração de
ludocard-restore-failed-for = Falha ao restaurar
ludocard-never = Nunca

ludocard-scan-title = Escanear & Adicionar
ludocard-scan-desc = Encontre saves de jogos no seu computador
ludocard-auto-search = Busca automática
ludocard-auto-search-desc = Varre as pastas comuns do sistema (Steam, Epic, Documentos e AppData) e suas pastas customizadas em busca de novos saves ou alterações.
ludocard-scanning = Escaneando...
ludocard-start-scan = Iniciar varredura de alterações
ludocard-scan-completed = Varredura concluída
ludocard-scan-completed-desc = Detecção de alterações finalizada.
ludocard-scan-error = Erro ao realizar varredura.
ludocard-custom-folder = Personalizada
ludocard-default-folder = Padrão
ludocard-folder-added = Pasta adicionada ao monitoramento
ludocard-folder-added-success = Pasta adicionada com sucesso!
ludocard-folder-select-error = Erro ao selecionar/adicionar pasta.
ludocard-emulator-detected = A pasta selecionada pertence ao emulador { $emulator }.\n\nDeseja adicioná-la como um Emulador para rastrear os saves dos seus jogos automaticamente?
ludocard-adding-emulator = Adicionando emulador e escaneando saves...
ludocard-emulator-added-success = Emulador { $emulator } adicionado com sucesso! { $count } jogo(s) detectado(s) na pasta de saves.
ludocard-emulator-added-empty = Emulador { $emulator } adicionado! Nenhum save de jogo foi detectado na pasta.
ludocard-emulator-add-failed = Falha ao adicionar emulador: { $error }
ludocard-emulator-added-mock = Emulador adicionado com sucesso! (Mock)
ludocard-emulator-select-error = Erro ao selecionar/adicionar emulador.
ludocard-emulator-removed = Emulador removido
ludocard-emulator-remove-error = Erro ao remover emulador.
ludocard-folder-removed = Pasta removida do monitoramento
ludocard-folder-remove-error = Erro ao remover pasta.
ludocard-monitored-folders = Pastas monitoradas
ludocard-monitored-folders-desc = Diretórios raiz observados continuamente para novos saves.
ludocard-add-folder = Adicionar pasta
ludocard-no-folders-detected = Nenhuma pasta de jogos detectada automaticamente.
ludocard-click-add-folder-desc = Clique em "Adicionar pasta" para selecionar uma pasta de biblioteca ou emuladores.
ludocard-monitoring-active = Monitoramento active
ludocard-remove-folder = Remover pasta
ludocard-select-new-root = Selecionar nova pasta raiz
ludocard-monitored-emulators = Emuladores monitorados
ludocard-monitored-emulators-desc = Diretórios de emuladores observados para busca automática de saves de console.
ludocard-add-emulator = Adicionar emulador
ludocard-no-emulators-configured = Nenhum emulador configurado.
ludocard-click-add-emulator-desc = Clique em "Adicionar emulador" para importar saves de Switch, Wii, Wii U, GBA, PS2, etc.
ludocard-saves-integrated = Saves integrados à biblioteca
ludocard-remove-emulator = Remover emulador
ludocard-add-other-emulator = Adicionar outro emulador
ludocard-scan-results = Resultados da varredura
ludocard-scan-results-desc = Selecione quais jogos com saves novos ou alterados você deseja fazer backup.
ludocard-starting-batch-backup = Iniciando backup em lote para { $count } jogos...
ludocard-batch-backup-completed = Backup dos jogos selecionados concluído!
ludocard-batch-backup-failed = Falha no backup em lote.
ludocard-backup-selected = Fazer Backup Selecionados
ludocard-no-new-saves-detected = Nenhum novo save ou alteração detectada. Todos os jogos estão sincronizados!
ludocard-new-game = Novo Jogo
ludocard-changed-save = Alterado

ludocard-cloud-title = Nuvem & Sincronização
ludocard-cloud-desc = Configure o backup remoto dos seus saves
ludocard-cloud-provider = Provedor de nuvem
ludocard-cloud-provider-desc = Escolha onde seus backups serão armazenados remotamente.
ludocard-auth-status = Status de autenticação e armazenamento.
ludocard-connected-as = Conectado como { $account }
ludocard-oauth-authorized = Conta autorizada via OAuth
ludocard-disconnect = Desconectar
ludocard-space-used = Espaço utilizado
ludocard-connect-desc = Conecte sua conta { $provider } para habilitar o backup remoto dos seus saves.
ludocard-connect-btn = Conectar conta
ludocard-sync-rules = Regras de sincronização
ludocard-sync-rules-desc = Como os saves se movem entre o PC e a nuvem.
ludocard-auto-upload = Upload automático após backup local
ludocard-auto-upload-desc = Envia para a nuvem imediatamente após cada backup.
ludocard-auto-upload-enabled = Upload automático ligado
ludocard-auto-upload-disabled = Upload automático desligado
ludocard-download-if-newer = Baixar se o save remoto for mais recente
ludocard-download-if-newer-desc = Resolve conflitos priorizando a versão mais nova.
ludocard-auto-download-enabled = Download automático ligado
ludocard-auto-download-disabled = Download automático desligado
ludocard-disconnected-provider = { $provider } desconectado
ludocard-connected-provider = { $provider } conectado

ludocard-loading = Carregando...
ludocard-fetching-details = Buscando detalhes do jogo
ludocard-loading-details = Carregando detalhes do jogo...
ludocard-details-desc = Detalhes e histórico de backups
ludocard-back = Voltar
ludocard-select = Selecionar
ludocard-saved-versions = versões salvas
ludocard-backup-now = Fazer backup agora
ludocard-restore-latest = Restaurar última
ludocard-open-game-folder-desc = Abrir pasta de instalação do jogo no Windows Explorer
ludocard-game-folder = Pasta do Jogo
ludocard-open-save-folder-desc = Abrir pasta onde os saves ativos ficam armazenados
ludocard-save-folder = Pasta do Save
ludocard-open-backup-folder-desc = Abrir pasta de backup de saves do Ludocard
ludocard-backup-folder = Pasta de Backups
ludocard-export-save-desc = Exportar save como arquivo .ludocard compactado para compartilhar
ludocard-export-save = Exportar Save (.ludocard)
ludocard-status = Status
ludocard-saves-on-pc = Saves no PC
ludocard-total-backups = Total em backups
ludocard-quick-preferences = Preferências rápidas
ludocard-save-history = Histórico de Saves
ludocard-config-presets = Presets de Configuração
ludocard-saves-timeline = Linha do Tempo (Saves)
ludocard-presets-configs = Presets & Configurações
ludocard-no-backups-yet = Nenhum backup ainda
ludocard-do-first-backup-desc = Faça o primeiro backup deste jogo para começar a linha do tempo.
ludocard-active = Ativo
ludocard-disabled = Desativado

ludocard-support-title = Apoiar o Projeto
ludocard-support-desc = Ajude a manter os servidores comunitários de saves e presets online
ludocard-support-intro-title = O Ludocard é totalmente gratuito!
ludocard-support-intro-desc = Nossos recursos de nuvem (Save Share Hub e Presets) geram custos mensais de servidores e tráfego. Se o aplicativo é útil para você, considere apoiar para ajudar a mantê-los online!
ludocard-how-to-support = Como Apoiar o Projeto
ludocard-how-to-support-desc = Escolha a sua forma de contribuição preferida. O Stripe oferece suporte a cartões de crédito e PIX nacional.
ludocard-support-itch = Apoiar no Itch.io
ludocard-support-stripe = Cartão / PIX via Stripe
ludocard-support-dest-desc = Toda contribuição é integralmente voltada para a manutenção dos servidores em nuvem (hospedagem e tráfego de dados).

ludocard-community-title = Save Share HUB
ludocard-community-desc = Compartilhe e baixe checkpoints de saves da comunidade
ludocard-btn-share-checkpoint = Compartilhar Checkpoint
ludocard-repo-disconnected = Repositório Comunitário Desconectado
ludocard-repo-disconnected-desc = Para carregar os checkpoints comunitários e compartilhar os seus, você precisa configurar a URL do seu Supabase e a Anon Key pública na aba de Configurações.
ludocard-how-to-config = Como configurar:
ludocard-config-step-1 = Crie um projeto gratuito no Supabase.
ludocard-config-step-2 = Crie as tabelas executando o script SQL que geramos no arquivo supabase/schema.sql.
ludocard-config-step-3 = Insira a URL da API e a Anon Key pública nas Configurações do Ludocard.
ludocard-checkpoints = Checkpoints
ludocard-contributors = Contribuidores
ludocard-search-placeholder = Buscar por jogo ou checkpoint...
ludocard-sort-popular = Popular
ludocard-sort-recent-hub = Recentes
ludocard-sort-size-hub = Tamanho
ludocard-syncing-repo = Sincronizando com o repositório público...
ludocard-no-checkpoints-found = Nenhum checkpoint encontrado
ludocard-no-checkpoints-available = Nenhum checkpoint disponível
ludocard-search-terms-desc = Tente buscar com outros termos.
ludocard-be-first-desc = Seja o primeiro a compartilhar um save da comunidade!
ludocard-no-desc-provided = Nenhuma descrição detalhada fornecida.
ludocard-author-by = por
ludocard-zstd-verified = Contém metadados zstd verificados
ludocard-btn-install = Instalar
ludocard-btn-installing = Instalando...
ludocard-security-sandbox-title = Segurança Automática do Seguro-Crash e Sandbox
ludocard-security-sandbox-desc = Ao instalar um checkpoint da comunidade, o Ludocard automaticamente cria um backup de segurança do seu save atual antes de sobrescrever. Se algo der errado, é só restaurar o backup anterior no histórico.
ludocard-share-checkpoint-modal = Compartilhar Checkpoint
ludocard-publish-progress-desc = Publique o seu arquivo de progresso para a comunidade.
ludocard-save-game-label = Jogo do Save *
ludocard-search-installed-game = Digite para pesquisar um jogo instalado...
ludocard-backup-version-label = Versão do Backup *
ludocard-no-local-backups-desc = Nenhum backup local feito para este jogo ainda. Crie um backup no card do jogo primeiro.
ludocard-checkpoint-title-label = Título do Checkpoint *
ludocard-checkpoint-title-placeholder = Ex: Antes da Malênia ou Level 100 100% Completo
ludocard-checkpoint-author-label = Nome do Autor
ludocard-checkpoint-author-placeholder = Ex: Anônimo
ludocard-checkpoint-desc-label = Descrição / Notas Adicionais
ludocard-checkpoint-desc-placeholder = Descreva detalhes como build, nível, itens importantes ou o momento do progresso.
ludocard-checkpoint-tags-label = Tags do Checkpoint
ludocard-btn-cancel = Cancelar
ludocard-btn-publishing = Publicando...
ludocard-btn-publish = Publicar Checkpoint
ludocard-detail-modal-desc = Visualizando metadados completos do checkpoint.
ludocard-btn-close = Fechar
ludocard-btn-download-install = Baixar & Instalar
ludocard-detail-title-label = Título do Checkpoint:
ludocard-detail-desc-label = Descrição do Progresso:
ludocard-detail-tags-label = Marcadores:
ludocard-detail-size-label = Tamanho Comprimido:
ludocard-detail-downloads-label = Total Downloads:
ludocard-detail-author-label = Enviado por:
ludocard-detail-date-label = Enviado em:
ludocard-date-today = Hoje
ludocard-date-yesterday = Ontem
ludocard-date-days-ago = dias atrás
ludocard-date-weeks-ago = semanas atrás
ludocard-date-locale = pt-BR

ludocard-presethub-title = Preset Share HUB
ludocard-presethub-desc = Descubra e compartilhe otimizações de gráficos e controles da comunidade
ludocard-btn-share-preset = Compartilhar Preset
ludocard-presethub-disconnected = Repositório de Presets Desconectado
ludocard-presethub-disconnected-desc = Para carregar os presets comunitários e compartilhar os seus, você precisa configurar a URL do seu Supabase e a Anon Key pública na aba de Configurações.
ludocard-presets = Presets
ludocard-preset-search-placeholder = Buscar por jogo, título ou hardware (ex: RTX 4070)...
ludocard-syncing-presets = Sincronizando presets...
ludocard-no-presets-found = Nenhum preset gráfico encontrado
ludocard-search-terms-desc-preset = Tente redefinir seus termos de busca.
ludocard-badge-official = Oficial
ludocard-gpu = GPU
ludocard-approval = Aprovação
ludocard-useful = Useful
ludocard-useless = Useless
ludocard-report-preset = Denunciar preset
ludocard-btn-undo = Desfazer
ludocard-btn-inject = Injetar
ludocard-btn-injecting = Injetando...
ludocard-not-installed = Não Instalado
ludocard-security-safety-title = Segurança Garantida pelo Seguro-Crash
ludocard-security-safety-desc = Ao baixar qualquer preset gráfico do HUB, o Ludocard faz backup das suas configurações anteriores. Os seus saves de progresso permanecem intocados.
ludocard-share-preset-modal-title = Compartilhar Preset Gráfico
ludocard-share-preset-modal-desc = Envie um preset gráfico local para a comunidade.
ludocard-preset-game-label = Jogo do Preset *
ludocard-search-installed-game-preset = Pesquisar jogo instalado...
ludocard-choose-local-preset-label = Escolher Preset Local *
ludocard-no-local-presets-desc = Nenhum preset local salvo para este jogo. Vá na aba do jogo e crie um preset local primeiro!
ludocard-preset-title-label = Título do Preset *
ludocard-preset-creator-label = Autor / Criador
ludocard-preset-desc-label = Descrição / Notas do Preset
ludocard-preset-tags-label = Tags do Preset
ludocard-preset-hardware-label = Hardware do Autor (Auto-preenchido do preset local):
ludocard-cpu = CPU
ludocard-ram = RAM
ludocard-btn-publish-preset = Publicar Preset
ludocard-detail-preset-title = Título do Preset:
ludocard-detail-preset-desc = Descrição / Otimizações:
ludocard-detail-author-specs = Especificações do Autor:

ludocard-tag-desc-100 = Jogo 100% concluído com todas as conquistas, itens e colecionáveis liberados.
ludocard-tag-desc-dlc1 = Progresso focado ou pronto para iniciar a primeira DLC do jogo.
ludocard-tag-desc-dlc2 = Progresso focado ou pronto para iniciar a segunda DLC do jogo.
ludocard-tag-desc-ngplus = Jogo pronto para iniciar ou já iniciado no modo Novo Jogo+.
ludocard-tag-desc-vanilla = Progresso do jogo base totalmente limpo, sem modificadores, mods ou trapaças.
ludocard-tag-desc-modded = Progresso obtido utilizando modificações (mods) que podem alterar a gameplay.
ludocard-tag-desc-bossprep = Save posicionado estrategicamente logo antes de um chefe importante do jogo.
ludocard-tag-desc-starter = Save no início do jogo, com recursos acumulados ou com tutorial pulado.
ludocard-tag-desc-cleanstart = Savegame logo após a criação de personagem ou introdução, pronto para jogar direto do início real.
ludocard-tag-desc-midgame = Save posicionado no meio da campanha principal (ótimo para quem perdeu o progresso).
ludocard-tag-desc-postgame = Campanha concluída, ideal para exploração de bosses secretos, conquistas pendentes ou atividades secundárias.
ludocard-tag-desc-opbuild = Savegame focado em um personagem com equipamentos, nível e builds extremamente fortes (Overpowered).
ludocard-tag-desc-unlimitedcash = Save focado em ter dinheiro, moedas ou recursos de upgrades máximos ou infinitos.
ludocard-tag-desc-allcollectibles = Save com foco em conquistas secundárias e colecionáveis cansativos totalmente liberados.
ludocard-tag-desc-hardcore = Saves em dificuldades extremas ou com morte permanente ativada (sobrevivência extrema).
ludocard-tag-desc-speedrunready = Save ideal para treinar trechos de speedruns ou posicionado nas rotas mais rápidas.
ludocard-tag-desc-legit = Progresso obtido de forma limpa, sem cheats, códigos de trapaça ou aproveitamento de bugs (glitches).
ludocard-preset-tag-desc-perf = Otimizações focadas em ganho de FPS e fluidez.
ludocard-preset-tag-desc-quality = Otimizações focadas em qualidade gráfica máxima.
ludocard-preset-tag-desc-balanced = Equilíbrio ideal entre fidelidade visual e taxa de FPS.
ludocard-preset-tag-desc-deck = Perfil otimizado especificamente para a tela e bateria do Steam Deck/portáteis.
ludocard-preset-tag-desc-potato = Para rodar em PCs super antigos e notebooks modestos.
ludocard-preset-tag-desc-controls = Mapeamento customizado de controles, gamepad ou hotkeys.
ludocard-preset-tag-desc-rt = Configuração refinada com traçado de raio ativo, visando boa taxa de quadros.
ludocard-preset-tag-desc-4k = Otimizações focadas em TVs e monitores 4K de alta definição.
ludocard-preset-tag-desc-vr = Configurações ajustadas para taxa de FPS ideal em realidade virtual.

ludocard-schedule-auto-routine = Rotina de saves automáticos
ludocard-schedule-auto-routine-desc = Defina quando os backups acontecem.
ludocard-schedule-by-interval = Por intervalo
ludocard-schedule-by-days = Dias da semana
ludocard-schedule-backup-every = Fazer backup a cada
ludocard-schedule-1-hour = 1 hora
ludocard-schedule-3-hours = 3 horas
ludocard-schedule-6-hours = 6 horas
ludocard-schedule-12-hours = 12 horas
ludocard-schedule-24-hours = 24 horas
ludocard-schedule-at-time = No horário
ludocard-schedule-games-in-schedule = Jogos no cronograma
ludocard-schedule-games-in-schedule-desc = Selecione quais jogos seguem esta rotina automática.
ludocard-schedule-btn-save = Salvar cronograma
ludocard-schedule-saved-toast = Cronograma salvo

ludocard-day-sun = Dom
ludocard-day-mon = Seg
ludocard-day-tue = Ter
ludocard-day-wed = Qua
ludocard-day-thu = Qui
ludocard-day-fri = Sex
ludocard-day-sat = Sáb

ludocard-notification-alerts = Alertas e notificações
ludocard-notification-alerts-desc = Como você quer ser avisado sobre os backups.
ludocard-notification-windows = Notificações do Windows
ludocard-notification-windows-desc = Avisa quando um backup é concluído com sucesso.
ludocard-notification-toast-enabled = Notificações ligadas
ludocard-notification-toast-disabled = Notificações desligadas
ludocard-notification-fail-alerts = Alertas de falha
ludocard-notification-fail-alerts-desc = Notifica imediatamente quando um backup falha.
ludocard-notification-toast-fail-enabled = Alertas de falha ligados
ludocard-notification-toast-fail-disabled = Alertas de falha desligados
ludocard-notification-sounds = Sons de alerta
ludocard-notification-sounds-desc = Toca um som ao concluir ou falhar um backup.
ludocard-notification-toast-sounds-enabled = Sons ligados
ludocard-notification-toast-sounds-disabled = Sons desligados


