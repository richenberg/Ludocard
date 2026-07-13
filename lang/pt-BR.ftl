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

luducard-library = Biblioteca
luducard-scan-and-add = Escanear & Adicionar
luducard-cloud-and-sync = Nuvem & Sincronização
luducard-save-share-hub = Save Share HUB
luducard-preset-share-hub = Preset Share HUB
luducard-settings = Configurações
luducard-support-project = Apoiar o Projeto
luducard-library-status = Status da biblioteca
luducard-games = Jogos
luducard-language = Idioma
luducard-language-desc = Idioma da interface.
luducard-sidebar-subtitle = Backup de saves
luducard-navigation = Navegação
luducard-stored-saves = Saves armazenados
luducard-pending-saves = Pendentes
luducard-downloading-covers = Baixando capas...
luducard-settings-desc = Preferências e comportamento do aplicativo
luducard-dashboard-desc = Gerencie e proteja os saves dos seus jogos

luducard-file-watcher = Monitor de Saves (File Watcher)
luducard-file-watcher-desc = Monitora alterações nos saves e faz backup automático quando o jogo fechar.
luducard-start-with-windows = Iniciar com o Windows
luducard-start-with-windows-desc = Abre minimizado na bandeja do sistema ao ligar o PC.
luducard-system-tray = Executar na Bandeja (System Tray)
luducard-system-tray-desc = Minimiza o aplicativo perto do relógio ao invés de fechar, mantendo o monitoramento em segundo plano.
luducard-portable = Modo Portátil (Portable Mode)
luducard-portable-desc = Salva todas as configurações, manifestos e backups na pasta do executável (ideal para pendrives).
luducard-show-notes-in-library = Exibir Diário de Bordo na Biblioteca
luducard-show-notes-in-library-desc = Mostra o campo de anotações rápidas diretamente nos cartões e linhas da lista de jogos.
luducard-theme = Tema
luducard-theme-desc = Aparência da interface do aplicativo.
luducard-theme-dark = Escuro
luducard-theme-light = Claro
luducard-theme-system = Sistema
luducard-backup-dir = Diretório de Backup
luducard-backup-dir-desc = Onde os saves dos seus jogos serão guardados localmente.

luducard-rclone-path = Caminho do executável Rclone
luducard-rclone-path-desc = Caminho para o executável rclone usado no envio para nuvem.
luducard-cloud-folder = Pasta Remota na Nuvem
luducard-cloud-folder-desc = Nome da pasta remota para sincronizar os arquivos.
luducard-rclone-args = Argumentos extras do Rclone
luducard-rclone-args-desc = Comandos e flags opcionais passados diretamente ao rclone.
luducard-supabase-url = URL do Supabase (Repositório Comunitário)
luducard-supabase-url-desc = URL da API do seu projeto Supabase para a aba de comunidade.
luducard-supabase-key = Anon Key do Supabase
luducard-supabase-key-desc = Chave pública (anon) usada para autenticação anônima nas tabelas.
luducard-btn-save-settings = Salvar Configurações

luducard-tab-general = Geral
luducard-tab-schedule = Agendamento
luducard-tab-notifications = Notificações
luducard-general-preferences = Preferências gerais
luducard-general-preferences-desc = Caminhos e comportamento básico do aplicativo.

luducard-status-synchronized = Sincronizado
luducard-status-pending = Backup pendente
luducard-status-none = Sem backup
luducard-backup = Backup
luducard-restore = Restaurar
luducard-current-save = Save Ativo
luducard-last-backup = Último Backup
luducard-manual-backup = Backup Manual
luducard-loading-library = Carregando biblioteca de jogos...
luducard-monitored-games = Jogos Monitorados
luducard-cloud-synced = Sincronizados na Nuvem
luducard-pending-saves-plural = Backups Pendentes
luducard-search-games = Buscar jogos...
luducard-clear-search = Limpar busca
luducard-select-all = Selecionar todos
luducard-platform = Plataforma
luducard-all-platforms = Todas as Plataformas
luducard-sort-by = Ordenar por
luducard-sort-name = Nome (A-Z)
luducard-sort-recent = Jogado recentemente
luducard-sort-size = Tamanho do save
luducard-installed = Instalado
luducard-pending = Pendente
luducard-grid-view = Visualização em grade
luducard-list-view = Visualização em lista
luducard-showing = Exibindo
luducard-of = de
luducard-game = jogo
luducard-games-plural = jogos
luducard-no-games-found = Nenhum jogo encontrado
luducard-adjust-filters-desc = Ajuste os filtros ou varra suas pastas para adicionar novos jogos.
luducard-starting-backup-for = Iniciando backup para
luducard-backup-completed-for = Backup de
luducard-completed = concluído!
luducard-completed-fem = concluída!
luducard-backup-failed-for = Falha no backup de
luducard-restoring-backup-for = Restaurando backup de
luducard-restore-completed-for = Restauração de
luducard-restore-failed-for = Falha ao restaurar
luducard-never = Nunca

luducard-scan-title = Escanear & Adicionar
luducard-scan-desc = Encontre saves de jogos no seu computador
luducard-auto-search = Busca de Saves
luducard-auto-search-desc = Varre as pastas customizadas em busca de novos saves.
luducard-scanning = Escaneando...
luducard-start-scan = Iniciar Varredura
luducard-scan-completed = Varredura concluída
luducard-scan-completed-desc = Detecção de alterações finalizada.
luducard-scan-error = Erro ao realizar varredura.
luducard-custom-folder = Personalizada
luducard-default-folder = Padrão
luducard-folder-added = Pasta adicionada ao monitoramento
luducard-folder-added-success = Pasta adicionada com sucesso!
luducard-folder-select-error = Erro ao selecionar/adicionar pasta.
luducard-emulator-detected = A pasta selecionada pertence ao emulador { $emulator }.\n\nDeseja adicioná-la como um Emulador para rastrear os saves dos seus jogos automaticamente?
luducard-adding-emulator = Adicionando emulador e escaneando saves...
luducard-emulator-added-success = Emulador { $emulator } adicionado com sucesso! { $count } jogo(s) detectado(s) na pasta de saves.
luducard-emulator-added-empty = Emulador { $emulator } adicionado! Nenhum save de jogo foi detectado na pasta.
luducard-emulator-add-failed = Falha ao adicionar emulador: { $error }
luducard-emulator-added-mock = Emulador adicionado com sucesso! (Mock)
luducard-emulator-select-error = Erro ao selecionar/adicionar emulador.
luducard-emulator-removed = Emulador removido
luducard-emulator-remove-error = Erro ao remover emulador.
luducard-folder-removed = Pasta removida do monitoramento
luducard-folder-remove-error = Erro ao remover pasta.
luducard-monitored-folders = Pastas monitoradas
luducard-monitored-folders-desc = Diretórios raiz observados continuamente para novos saves.
luducard-add-folder = Adicionar pasta
luducard-no-folders-detected = Nenhuma pasta de jogos detectada automaticamente.
luducard-click-add-folder-desc = Clique em "Adicionar pasta" para selecionar uma pasta de biblioteca ou emuladores.
luducard-monitoring-active = Monitoramento active
luducard-remove-folder = Remover pasta
luducard-select-new-root = Selecionar nova pasta raiz
luducard-monitored-emulators = Emuladores monitorados
luducard-monitored-emulators-desc = Diretórios de emuladores observados para busca automática de saves de console.
luducard-add-emulator = Adicionar emulador
luducard-no-emulators-configured = Nenhum emulador configurado.
luducard-click-add-emulator-desc = Clique em "Adicionar emulador" para importar saves de Switch, Wii, Wii U, GBA, PS2, etc.
luducard-saves-integrated = Saves integrados à biblioteca
luducard-remove-emulator = Remover emulador
luducard-add-other-emulator = Adicionar outro emulador
luducard-scan-results = Resultados da varredura
luducard-scan-results-desc = Selecione quais jogos com saves novos ou alterados você deseja fazer backup.
luducard-starting-batch-backup = Iniciando backup em lote para { $count } jogos...
luducard-batch-backup-completed = Backup dos jogos selecionados concluído!
luducard-batch-backup-failed = Falha no backup em lote.
luducard-backup-selected = Fazer Backup Selecionados
luducard-no-new-saves-detected = Nenhum novo save ou alteração detectada. Todos os jogos estão sincronizados!
luducard-new-game = Novo Jogo
luducard-changed-save = Alterado

luducard-cloud-title = Nuvem & Sincronização
luducard-cloud-desc = Configure o backup remoto dos seus saves
luducard-cloud-provider = Provedor de nuvem
luducard-cloud-provider-desc = Escolha onde seus backups serão armazenados remotamente.
luducard-auth-status = Status de autenticação e armazenamento.
luducard-connected-as = Conectado como { $account }
luducard-oauth-authorized = Conta autorizada via OAuth
luducard-disconnect = Desconectar
luducard-space-used = Espaço utilizado
luducard-connect-desc = Conecte sua conta { $provider } para habilitar o backup remoto dos seus saves.
luducard-connect-btn = Conectar conta
luducard-sync-rules = Regras de sincronização
luducard-sync-rules-desc = Como os saves se movem entre o PC e a nuvem.
luducard-auto-upload = Upload automático após backup local
luducard-auto-upload-desc = Envia para a nuvem imediatamente após cada backup.
luducard-auto-upload-enabled = Upload automático ligado
luducard-auto-upload-disabled = Upload automático desligado
luducard-download-if-newer = Baixar se o save remoto for mais recente
luducard-download-if-newer-desc = Resolve conflitos priorizando a versão mais nova.
luducard-auto-download-enabled = Download automático ligado
luducard-auto-download-disabled = Download automático desligado
luducard-disconnected-provider = { $provider } desconectado
luducard-connected-provider = { $provider } conectado

luducard-loading = Carregando...
luducard-fetching-details = Buscando detalhes do jogo
luducard-loading-details = Carregando detalhes do jogo...
luducard-details-desc = Detalhes e histórico de backups
luducard-back = Voltar
luducard-select = Selecionar
luducard-saved-versions = versões salvas
luducard-backup-now = Fazer backup agora
luducard-restore-latest = Restaurar última
luducard-open-game-folder-desc = Abrir pasta de instalação do jogo no Windows Explorer
luducard-game-folder = Pasta do Jogo
luducard-open-save-folder-desc = Abrir pasta onde os saves ativos ficam armazenados
luducard-save-folder = Pasta do Save
luducard-open-backup-folder-desc = Abrir pasta de backup de saves do Luducard
luducard-backup-folder = Pasta de Backups
luducard-export-save-desc = Exportar save como arquivo .luducard compactado para compartilhar
luducard-export-save = Exportar Save (.luducard)
luducard-status = Status
luducard-saves-on-pc = Saves no PC
luducard-total-backups = Total em backups
luducard-quick-preferences = Preferências rápidas
luducard-save-history = Histórico de Saves
luducard-config-presets = Presets de Configuração
luducard-saves-timeline = Linha do Tempo (Saves)
luducard-presets-configs = Presets & Configurações
luducard-no-backups-yet = Nenhum backup ainda
luducard-do-first-backup-desc = Faça o primeiro backup deste jogo para começar a linha do tempo.
luducard-active = Ativo
luducard-disabled = Desativado

luducard-support-title = Apoiar o Projeto
luducard-support-desc = Ajude a manter os servidores comunitários de saves e presets online
luducard-support-intro-title = O Luducard é totalmente gratuito!
luducard-support-intro-desc = Nossos recursos de nuvem (Save Share Hub e Presets) geram custos mensais de servidores e tráfego. Se o aplicativo é útil para você, considere apoiar para ajudar a mantê-los online!
luducard-how-to-support = Como Apoiar o Projeto
luducard-how-to-support-desc = Escolha a sua forma de contribuição preferida. O Stripe oferece suporte a cartões de crédito e PIX nacional.
luducard-support-itch = Apoiar no Itch.io
luducard-support-stripe = Cartão / PIX via Stripe
luducard-support-dest-desc = Toda contribuição é integralmente voltada para a manutenção dos servidores em nuvem (hospedagem e tráfego de dados).

luducard-community-title = Save Share HUB
luducard-community-desc = Compartilhe e baixe checkpoints de saves da comunidade
luducard-btn-share-checkpoint = Compartilhar Checkpoint
luducard-repo-disconnected = Repositório Comunitário Desconectado
luducard-repo-disconnected-desc = Para carregar os checkpoints comunitários e compartilhar os seus, você precisa configurar a URL do seu Supabase e a Anon Key pública na aba de Configurações.
luducard-how-to-config = Como configurar:
luducard-config-step-1 = Crie um projeto gratuito no Supabase.
luducard-config-step-2 = Crie as tabelas executando o script SQL que geramos no arquivo supabase/schema.sql.
luducard-config-step-3 = Insira a URL da API e a Anon Key pública nas Configurações do Luducard.
luducard-checkpoints = Checkpoints
luducard-contributors = Contribuidores
luducard-search-placeholder = Buscar por jogo ou checkpoint...
luducard-sort-popular = Popular
luducard-sort-recent-hub = Recentes
luducard-sort-size-hub = Tamanho
luducard-syncing-repo = Sincronizando com o repositório público...
luducard-no-checkpoints-found = Nenhum checkpoint encontrado
luducard-no-checkpoints-available = Nenhum checkpoint disponível
luducard-search-terms-desc = Tente buscar com outros termos.
luducard-be-first-desc = Seja o primeiro a compartilhar um save da comunidade!
luducard-no-desc-provided = Nenhuma descrição detalhada fornecida.
luducard-author-by = por
luducard-zstd-verified = Contém metadados zstd verificados
luducard-btn-install = Instalar
luducard-btn-installing = Instalando...
luducard-security-sandbox-title = Segurança Automática do Seguro-Crash e Sandbox
luducard-security-sandbox-desc = Ao instalar um checkpoint da comunidade, o Luducard automaticamente cria um backup de segurança do seu save atual antes de sobrescrever. Se algo der errado, é só restaurar o backup anterior no histórico.
luducard-share-checkpoint-modal = Compartilhar Checkpoint
luducard-publish-progress-desc = Publique o seu arquivo de progresso para a comunidade.
luducard-save-game-label = Jogo do Save *
luducard-search-installed-game = Digite para pesquisar um jogo instalado...
luducard-backup-version-label = Versão do Backup *
luducard-no-local-backups-desc = Nenhum backup local feito para este jogo ainda. Crie um backup no card do jogo primeiro.
luducard-checkpoint-title-label = Título do Checkpoint *
luducard-checkpoint-title-placeholder = Ex: Antes da Malênia ou Level 100 100% Completo
luducard-checkpoint-author-label = Nome do Autor
luducard-checkpoint-author-placeholder = Ex: Anônimo
luducard-checkpoint-desc-label = Descrição / Notas Adicionais
luducard-checkpoint-desc-placeholder = Descreva detalhes como build, nível, itens importantes ou o momento do progresso.
luducard-checkpoint-tags-label = Tags do Checkpoint
luducard-btn-cancel = Cancelar
luducard-btn-publishing = Publicando...
luducard-btn-publish = Publicar Checkpoint
luducard-detail-modal-desc = Visualizando metadados completos do checkpoint.
luducard-btn-close = Fechar
luducard-btn-download-install = Baixar & Instalar
luducard-detail-title-label = Título do Checkpoint:
luducard-detail-desc-label = Descrição do Progresso:
luducard-detail-tags-label = Marcadores:
luducard-detail-size-label = Tamanho Comprimido:
luducard-detail-downloads-label = Total Downloads:
luducard-detail-author-label = Enviado por:
luducard-detail-date-label = Enviado em:
luducard-date-today = Hoje
luducard-date-yesterday = Ontem
luducard-date-days-ago = dias atrás
luducard-date-weeks-ago = semanas atrás
luducard-date-locale = pt-BR

luducard-presethub-title = Preset Share HUB
luducard-presethub-desc = Descubra e compartilhe otimizações de gráficos e controles da comunidade
luducard-btn-share-preset = Compartilhar Preset
luducard-presethub-disconnected = Repositório de Presets Desconectado
luducard-presethub-disconnected-desc = Para carregar os presets comunitários e compartilhar os seus, você precisa configurar a URL do seu Supabase e a Anon Key pública na aba de Configurações.
luducard-presets = Presets
luducard-preset-search-placeholder = Buscar por jogo, título ou hardware (ex: RTX 4070)...
luducard-syncing-presets = Sincronizando presets...
luducard-no-presets-found = Nenhum preset gráfico encontrado
luducard-search-terms-desc-preset = Tente redefinir seus termos de busca.
luducard-badge-official = Oficial
luducard-gpu = GPU
luducard-approval = Aprovação
luducard-useful = Useful
luducard-useless = Useless
luducard-report-preset = Denunciar preset
luducard-btn-undo = Desfazer
luducard-btn-inject = Injetar
luducard-btn-injecting = Injetando...
luducard-not-installed = Não Instalado
luducard-security-safety-title = Segurança Garantida pelo Seguro-Crash
luducard-security-safety-desc = Ao baixar qualquer preset gráfico do HUB, o Luducard faz backup das suas configurações anteriores. Os seus saves de progresso permanecem intocados.
luducard-share-preset-modal-title = Compartilhar Preset Gráfico
luducard-share-preset-modal-desc = Envie um preset gráfico local para a comunidade.
luducard-preset-game-label = Jogo do Preset *
luducard-search-installed-game-preset = Pesquisar jogo instalado...
luducard-choose-local-preset-label = Escolher Preset Local *
luducard-no-local-presets-desc = Nenhum preset local salvo para este jogo. Vá na aba do jogo e crie um preset local primeiro!
luducard-preset-title-label = Título do Preset *
luducard-preset-creator-label = Autor / Criador
luducard-preset-desc-label = Descrição / Notas do Preset
luducard-preset-tags-label = Tags do Preset
luducard-preset-hardware-label = Hardware do Autor (Auto-preenchido do preset local):
luducard-cpu = CPU
luducard-ram = RAM
luducard-btn-publish-preset = Publicar Preset
luducard-detail-preset-title = Título do Preset:
luducard-detail-preset-desc = Descrição / Otimizações:
luducard-detail-author-specs = Especificações do Autor:

luducard-tag-desc-100 = Jogo 100% concluído com todas as conquistas, itens e colecionáveis liberados.
luducard-tag-desc-dlc1 = Progresso focado ou pronto para iniciar a primeira DLC do jogo.
luducard-tag-desc-dlc2 = Progresso focado ou pronto para iniciar a segunda DLC do jogo.
luducard-tag-desc-ngplus = Jogo pronto para iniciar ou já iniciado no modo Novo Jogo+.
luducard-tag-desc-vanilla = Progresso do jogo base totalmente limpo, sem modificadores, mods ou trapaças.
luducard-tag-desc-modded = Progresso obtido utilizando modificações (mods) que podem alterar a gameplay.
luducard-tag-desc-bossprep = Save posicionado estrategicamente logo antes de um chefe importante do jogo.
luducard-tag-desc-starter = Save no início do jogo, com recursos acumulados ou com tutorial pulado.
luducard-tag-desc-cleanstart = Savegame logo após a criação de personagem ou introdução, pronto para jogar direto do início real.
luducard-tag-desc-midgame = Save posicionado no meio da campanha principal (ótimo para quem perdeu o progresso).
luducard-tag-desc-postgame = Campanha concluída, ideal para exploração de bosses secretos, conquistas pendentes ou atividades secundárias.
luducard-tag-desc-opbuild = Savegame focado em um personagem com equipamentos, nível e builds extremamente fortes (Overpowered).
luducard-tag-desc-unlimitedcash = Save focado em ter dinheiro, moedas ou recursos de upgrades máximos ou infinitos.
luducard-tag-desc-allcollectibles = Save com foco em conquistas secundárias e colecionáveis cansativos totalmente liberados.
luducard-tag-desc-hardcore = Saves em dificuldades extremas ou com morte permanente ativada (sobrevivência extrema).
luducard-tag-desc-speedrunready = Save ideal para treinar trechos de speedruns ou posicionado nas rotas mais rápidas.
luducard-tag-desc-legit = Progresso obtido de forma limpa, sem cheats, códigos de trapaça ou aproveitamento de bugs (glitches).
luducard-preset-tag-desc-perf = Otimizações focadas em ganho de FPS e fluidez.
luducard-preset-tag-desc-quality = Otimizações focadas em qualidade gráfica máxima.
luducard-preset-tag-desc-balanced = Equilíbrio ideal entre fidelidade visual e taxa de FPS.
luducard-preset-tag-desc-deck = Perfil otimizado especificamente para a tela e bateria do Steam Deck/portáteis.
luducard-preset-tag-desc-potato = Para rodar em PCs super antigos e notebooks modestos.
luducard-preset-tag-desc-controls = Mapeamento customizado de controles, gamepad ou hotkeys.
luducard-preset-tag-desc-rt = Configuração refinada com traçado de raio ativo, visando boa taxa de quadros.
luducard-preset-tag-desc-4k = Otimizações focadas em TVs e monitores 4K de alta definição.
luducard-preset-tag-desc-vr = Configurações ajustadas para taxa de FPS ideal em realidade virtual.

luducard-schedule-auto-routine = Rotina de saves automáticos
luducard-schedule-auto-routine-desc = Defina quando os backups acontecem.
luducard-schedule-by-interval = Por intervalo
luducard-schedule-by-days = Dias da semana
luducard-schedule-backup-every = Fazer backup a cada
luducard-schedule-1-hour = 1 hora
luducard-schedule-3-hours = 3 horas
luducard-schedule-6-hours = 6 horas
luducard-schedule-12-hours = 12 horas
luducard-schedule-24-hours = 24 horas
luducard-schedule-at-time = No horário
luducard-schedule-games-in-schedule = Jogos no cronograma
luducard-schedule-games-in-schedule-desc = Selecione quais jogos seguem esta rotina automática.
luducard-schedule-btn-save = Salvar cronograma
luducard-schedule-saved-toast = Cronograma salvo

luducard-day-sun = Dom
luducard-day-mon = Seg
luducard-day-tue = Ter
luducard-day-wed = Qua
luducard-day-thu = Qui
luducard-day-fri = Sex
luducard-day-sat = Sáb

luducard-notification-alerts = Alertas e notificações
luducard-notification-alerts-desc = Como você quer ser avisado sobre os backups.
luducard-notification-windows = Notificações do Windows
luducard-notification-windows-desc = Avisa quando um backup é concluído com sucesso.
luducard-notification-toast-enabled = Notificações ligadas
luducard-notification-toast-disabled = Notificações desligadas
luducard-notification-fail-alerts = Alertas de falha
luducard-notification-fail-alerts-desc = Notifica imediatamente quando um backup falha.
luducard-notification-toast-fail-enabled = Alertas de falha ligados
luducard-notification-toast-fail-disabled = Alertas de falha desligados
luducard-notification-sounds = Sons de alerta
luducard-notification-sounds-desc = Toca um som ao concluir ou falhar um backup.
luducard-notification-toast-sounds-enabled = Sons ligados
luducard-notification-toast-sounds-disabled = Sons desligados

luducard-diario-bordo-placeholder = Diário de Bordo (anotações)...
luducard-diario-bordo-placeholder-short = Diário de Bordo...
luducard-campaign-notes = Diário de Bordo
luducard-campaign-notes-desc = Anotações rápidas sobre o seu progresso
luducard-campaign-notes-placeholder = Escreva anotações rápidas sobre o seu progresso neste jogo...
luducard-backup-all = Fazer backup de todos
luducard-discord-title = Comunidade no Discord
luducard-discord-desc = Tire dúvidas, reporte bugs, sugira funcionalidades e conecte-se com outros jogadores.
luducard-discord-join = Entrar no Discord
luducard-cloud-active = Sincronização em Nuvem Ativa e Saudável
luducard-cloud-paused = Sincronização em Nuvem Pausada
luducard-cloud-active-desc = Seus backups locais serão enviados e sincronizados automaticamente na nuvem.
luducard-cloud-paused-desc = O envio para a nuvem está pausado. Ative para sincronizar seus saves.
luducard-cloud-disconnect = Desconectar Conta
luducard-cloud-disconnect-btn = Desconectar


luducard-cloud-details-title = Detalhes da Conta
luducard-cloud-email = E-mail da Conta:
luducard-cloud-destination = Pasta de Destino:
luducard-cloud-engine = Motor do Backup:
luducard-cloud-path = Caminho Executável:
luducard-cloud-rules-title = Regras de Sincronização
luducard-cloud-upload-auto = Upload Automático
luducard-cloud-upload-auto-desc = Upar saves assim que o backup local for gerado.
luducard-cloud-download-latest = Baixar mais Recente
luducard-cloud-download-latest-desc = Dar prioridade aos arquivos mais novos na nuvem.
luducard-cloud-toast-upload-enabled = Upload automático ativado
luducard-cloud-toast-upload-disabled = Upload automático desativado
luducard-cloud-toast-download-enabled = Download automático ativado
luducard-cloud-toast-download-disabled = Download automático desativado
luducard-support-dest = Destinação dos Recursos
luducard-danger-zone = Zona de Perigo
luducard-danger-zone-desc = Ações destrutivas que não podem ser desfeitas.
luducard-reset-warning-title = AVISO IMPORTANTE:
luducard-reset-warning-desc = Isso apagará permanentemente todas as suas configurações, caminhos de busca personalizados, histórico de escaneamento de jogos, credenciais de nuvem e perfis de save criados. Suas pastas de backups originais no disco não serão excluídas.
luducard-btn-reset-app = Limpar Todos os Dados
luducard-btn-reset-confirm = Sim, Confirmar Exclusão
luducard-btn-reset-cancel = Cancelar
