ludusavi = Ludusavi
language = Язык
game-name = Название
total-games = Игры
file-size = Размер
file-location = Местоположение
overall = Всего
status = Статус
cli-unrecognized-games = Нет информации об этих играх:
cli-unable-to-request-confirmation = Не удалось запросить подтверждение.
    .winpty-workaround = Если вы используете эмулятор Bash (например Git Bash), попробуйте запустить winpty.
cli-backup-id-with-multiple-games = Невозможно задать идентификатор резервной копии при восстановлении нескольких игр.
cli-invalid-backup-id = Неверный идентификатор резервной копии.
badge-failed = ОШИБКА
badge-duplicates = ДУБЛИКАТ
badge-duplicated = ДУБЛИРОВАННЫЙ
badge-ignored = ИГНОРИРОВАН
badge-redirected-from = ИЗ: { $path }
badge-redirecting-to = В: { $path }
some-entries-failed = Некоторые записи не удалось обработать; ищите { badge-failed } на выходе для получения деталей. Дважды проверьте, имеют ли вы доступ к этим файлам или их пути очень длинные.
cli-game-line-item-redirected = Перенаправлено из: { $path }
cli-game-line-item-redirecting = Перенаправление в: { $path }
button-backup = Резервирование
button-preview = Предпросмотр
button-restore = Восстановить
button-nav-backup = РЕЗЕРВИРОВАНИЕ
button-nav-restore = ВОССТАНОВЛЕНИЕ
button-nav-custom-games = СВОЯ ИГРА
button-nav-other = ДРУГИЕ
button-add-game = Добавить игру
button-continue = Продолжить
button-cancel = Отменить
button-cancelling = Отменяю...
button-okay = Хорошо
button-select-all = Выбрать все
button-deselect-all = Снять все
button-enable-all = Включить все
button-disable-all = Отключить все
button-customize = Настроить
button-exit = Выйти
button-comment = Комментарий
button-lock = Заблокировать
button-unlock = Разблокировать
# This opens a download page.
button-get-app = Получить { $app }
button-validate = Проверить
button-override-manifest = Переопределить манифест
button-extend-manifest = Расширить манифест
button-sort = Сортировать
button-download = Скачать
button-upload = Загрузить
button-ignore = Игнорировать
no-roots-are-configured = Добавьте несколько корней для резервирования еще больше данных.
config-is-invalid = Ошибка: неверный файл конфигурации.
manifest-is-invalid = Ошибка: неверный файл конфигурации (манифеста).
manifest-cannot-be-updated = Ошибка: Невозможно проверить обновление файла манифеста. Подключение к Интернету отключено?
cannot-prepare-backup-target = Ошибка: Не удается подготовить резервную копию цели (либо создание, либо очистка папки). Если папка открыта в браузере файлов, попробуйте закрыть её: { $path }
restoration-source-is-invalid = Ошибка: Источник восстановления недействителен (либо не существует или не является каталогом). Пожалуйста, проверьте путь: { $path }
registry-issue = Ошибка: Некоторые записи реестра были пропущены.
unable-to-browse-file-system = Ошибка: Невозможна навигация по файловой системе.
unable-to-open-directory = Ошибка: Не удается открыть каталог:
unable-to-open-url = Ошибка: Не удается открыть URL:
unable-to-configure-cloud = Не удалось настроить облако.
unable-to-synchronize-with-cloud = Не удалось синхронизировать с облаком.
cloud-synchronize-conflict = Ваши локальные и облачные резервные копии конфликтуют. Выполните закачку или загрузку, чтобы разрешить это.
command-unlaunched = Команда не запущена: { $command }
command-terminated = Команда прервана: { $command }
command-failed = Не удалось выполнить команду с кодом { $code }: { $command }
processed-games =
    { $total-games } { $total-games ->
        [one] игр(а)
       *[other] игр(ы)
    }
processed-games-subset =
    { $processed-games } из { $total-games } { $total-games ->
        [one] игр(а)
       *[other] игр(ы)
    }
processed-size-subset = { $processed-size } из { $total-size }
field-backup-target = Резервировать в:
field-restore-source = Восстановить из:
field-custom-files = Пути:
field-custom-registry = Реестр:
field-sort = Сортировать:
field-redirect-source =
    .placeholder = Источник (исходное место)
field-redirect-target =
    .placeholder = Целевой (новое место)
field-roots = Корневые:
field-backup-excluded-items = Исключения из резервной копии:
field-redirects = Перенаправления:
# This appears next to the number of full backups that you'd like to keep.
# A full backup includes all save files for a game.
field-retention-full = Полный:
# This appears next to the number of differential backups that you'd like to keep.
# A differential backup includes only the files that have changed since the last full backup.
field-retention-differential = Дифференциальный:
field-backup-format = Формат:
field-backup-compression = Сжатие:
# The compression level determines how much compresison we perform.
field-backup-compression-level = Степень:
label-manifest = Манифест
# This shows the time when we checked for an update to the manifest.
label-checked = Проверен
# This shows the time when we found an update to the manifest.
label-updated = Обновлено
label-new = Новый
label-removed = Удалено
label-comment = Комментарий
label-unchanged = Без изменений
label-backup = Резервировать
label-scan = Сканирование
label-filter = Фильтр
label-unique = Уникальный
label-complete = Полный
label-partial = Частичный
label-enabled = Включено
label-disabled = Отключено
# https://en.wikipedia.org/wiki/Thread_(computing)
label-threads = Потоки
label-cloud = Облачное хранилище
# A "remote" is what Rclone calls cloud systems like Google Drive.
label-remote = Удалённый репозиторий
label-remote-name = Имя репозитория
label-folder = Папка
# An executable file
label-executable = Исполняемый файл
# Options given to a command line program
label-arguments = Аргументы
label-url = Ссылка
# https://en.wikipedia.org/wiki/Host_(network)
label-host = Хост
# https://en.wikipedia.org/wiki/Port_(computer_networking)
label-port = Порт
label-username = Имя пользователя
label-password = Пароль
# This is a specific website or service that provides some cloud functionality.
# For example, Nextcloud and Owncloud are providers of WebDAV services.
label-provider = Хранилище
label-custom = Пользовательское
label-none = Нет
label-change-count = Изменений: { $total }
label-unscanned = Непроверенные
# This refers to a local file on the computer
label-file = Файл
label-game = Игра
# Aliases are alternative titles for the same game.
label-alias = Псевдоним (похожее)
label-original-name = Исходное название
# Which manifest a game's data came from
label-source = Источник
# This refers to the main Ludusavi manifest: https://github.com/mtkennerly/ludusavi-manifest
label-primary-manifest = Основной манифест
# This refers to how we integrate a custom game with the manifest data.
label-integration = Интеграция
# This is a folder name where a specific game is installed
label-installed-name = Установленное имя
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
store-other-home = Домашняя папка
# This would be a folder acting as a virtual C: drive, created by Wine.
store-other-wine = Wine префикс
# This would be a folder with typical Windows system folders,
# like "Program Files (x86)" and "Users".
store-other-windows = Windows диск
# This would be a folder with typical Linux system folders,
# like "home" and "opt".
store-other-linux = Linux диск
# This would be a folder with typical Mac system folders,
# like "Applications" and "Users".
store-other-mac = Mac диск
store-other = Другое
backup-format-simple = Простой
backup-format-zip = Zip
compression-none = Нет
# "Deflate" is a proper noun: https://en.wikipedia.org/wiki/Deflate
compression-deflate = Дефляция
compression-bzip2 = Bzip2
compression-zstd = Zstd
theme = Тема оформления
theme-light = Светлая
theme-dark = Тёмная
redirect-bidirectional = Двунаправленный
reverse-redirects-when-restoring = Обратная последовательность перенаправлений при восстановлении
show-disabled-games = Показать неактивные игры
show-unchanged-games = Показать неизменные игры
show-unscanned-games = Показать несканированные игры
override-max-threads = Переопределить макс. количество потоков
synchronize-automatically = Синхронизировать автоматически
prefer-alias-display = Отображать своё название вместо исходного
skip-unconstructive-backups = Пропустить резервную копию, когда данные будут удалены, но не добавлены или обновлены
explanation-for-exclude-store-screenshots = В резервных копиях исключить скриншоты из конкретного магазина
explanation-for-exclude-cloud-games = Не создавать резервные копии игр с поддержкой облака на этих платформах
consider-doing-a-preview =
    Если вы еще этого не сделали, предлагаю сначала сделать предварительный просмотр, чтобы
    не было сюрпризов.
confirm-backup =
    Вы уверены, что хотите продолжить создание резервной копии? { $path-action ->
        [merge] Новые данные сохранения будут объединены в целевую папку:
       *[create] Будет создана целевая папка:
    }
confirm-restore =
    Вы уверены, что хотите продолжить восстановление?
    Это перезапишет все текущие файлы резервными копиями отсюда:
confirm-cloud-upload =
    Вы хотите заменить ваши облачные файлы локальными файлами?
    Ваши файлы в облаке ({ $cloud-path }) станут точной копией локальных файлов ({ $local-path }).
    Файлы в облаке будут обновлены или удалены по мере необходимости.
confirm-cloud-download =
    Вы хотите заменить локальные файлы на ваши облачные файлы?
    Ваши локальные файлы ({ $local-path }) станут точной копией ваших облачных файлов ({ $cloud-path }).
    По мере необходимости локальные файлы будут обновлены или удалены.
confirm-add-missing-roots = Добавить эти корневые папки?
no-missing-roots = Дополнительные корневые папки не найдены.
loading = Загрузка...
preparing-backup-target = Подготовка папки резервной копии...
updating-manifest = Обновление манифеста...
no-cloud-changes = Нет изменений для синхронизации
backups-are-valid = Ваши резервные копии действительны.
backups-are-invalid =
    Резервные копии этих игр кажутся недействительными.
    Вы хотите создать новые полные резервные копии для этих игр?
saves-found = Найдены данные сохранения.
no-saves-found = Сохраненных данных не найдено.
# This is tacked on to form something like "Back up (no confirmation)",
# meaning we would perform an action without asking the user if they're sure.
suffix-no-confirmation = без подтверждения
# This is shown when a setting will only take effect after closing and reopening Ludusavi.
suffix-restart-required = Требуется перезапуск
prefix-error = Ошибка: { $message }
prefix-warning = Внимание: { $message }
cloud-app-unavailable = Облачные резервные копии отключены, потому что { $app } недоступно.
cloud-not-configured = Облачные резервные копии отключены, так как облачная система не настроена.
cloud-path-invalid = Облачные резервные копии отключены, так как путь резервного копирования недействителен.
game-is-unrecognized = Ludusavi не распознает эту игру.
game-has-nothing-to-restore = У этой игры нет резервной копии для восстановления.
launch-game-after-error = Все равно запустить игру?
game-did-not-launch = Не удалось запустить игру.
backup-is-newer-than-current-data = Существующая резервная копия новее, чем текущая.
backup-is-older-than-current-data = Существующая резервная копия старше, чем текущая.
back-up-specific-game =
    .confirm = Создать резервную копию для { $game }?
    .failed = Не удалось сохранить данные для { $game }
restore-specific-game =
    .confirm = Восстановить сохраненные данные для { $game }?
    .failed = Не удалось восстановить данные для { $game }
new-version-check = Автоматически проверять обновления приложения
new-version-available = Доступно обновление приложения: { $version }. Хотите просмотреть список изменений (патчноут)?
custom-game-will-override = Пользовательская игра переопределяет элемент манифеста
custom-game-will-extend = Пользовательская игра расширяет манифест
operation-will-only-include-listed-games = Обработаются только перечисленные игры

ludocard-library = Библиотека
ludocard-scan-and-add = Сканирование и добавление
ludocard-cloud-and-sync = Облако и синхронизация
ludocard-save-share-hub = Save Share HUB
ludocard-preset-share-hub = Preset Share HUB
ludocard-settings = Настройки
ludocard-support-project = Поддержать проект
ludocard-library-status = Статус библиотеки
ludocard-games = Игры
ludocard-language = Язык
ludocard-language-desc = Язык интерфейса.
ludocard-sidebar-subtitle = Резервные копии сейвов
ludocard-navigation = Навигация
ludocard-stored-saves = Сохраненные файлы
ludocard-pending-saves = Ожидающие
ludocard-downloading-covers = Загрузка обложек...
ludocard-settings-desc = Настройки и поведение приложения
ludocard-dashboard-desc = Управляйте и защищайте сохранения ваших игр

ludocard-file-watcher = Монитор сохранений (File Watcher)
ludocard-file-watcher-desc = Отслеживает изменения сохранений и автоматически делает копию при закрытии игры.
ludocard-start-with-windows = Запуск вместе с Windows
ludocard-start-with-windows-desc = Запускается свернутым в системный трей при включении ПК.
ludocard-system-tray = Запуск в системном трее (System Tray)
ludocard-system-tray-desc = Сворачивает приложение в системный трей вместо закрытия, сохраняя фоновый мониторинг.
ludocard-portable = Портативный режим (Portable Mode)
ludocard-portable-desc = Сохраняет настройки, манифесты и резервные копии в папке приложения (идеально для флешек).
ludocard-theme = Тема
ludocard-theme-desc = Внешний вид интерфейса.
ludocard-theme-dark = Темная
ludocard-theme-light = Светлая
ludocard-theme-system = Системная
ludocard-backup-dir = Папка резервных копий
ludocard-backup-dir-desc = Где будут храниться файлы резервных копий сохранений.

ludocard-rclone-path = Путь к исполняемому файлу Rclone
ludocard-rclone-path-desc = Путь к исполняемому файлу rclone, используемому для загрузки в облако.
ludocard-cloud-folder = Удаленная папка в облаке
ludocard-cloud-folder-desc = Имя удаленной папки для синхронизации файлов.
ludocard-rclone-args = Дополнительные аргументы Rclone
ludocard-rclone-args-desc = Необязательные команды и флаги, передаваемые непосредственно в rclone.
ludocard-supabase-url = URL-адрес Supabase (Сообщество)
ludocard-supabase-url-desc = URL-адрес API вашего проекта Supabase для вкладки сообщества.
ludocard-supabase-key = Анонимный ключ Supabase (Anon Key)
ludocard-supabase-key-desc = Публичный (анонимный) ключ, используемый для анонимной аутентификации в таблицах.
ludocard-btn-save-settings = Сохранить настройки

ludocard-tab-general = Общие
ludocard-tab-schedule = Расписание
ludocard-tab-notifications = Уведомления
ludocard-general-preferences = Общие настройки
ludocard-general-preferences-desc = Пути приложения и базовое поведение.

ludocard-status-synchronized = Синхронизировано
ludocard-status-pending = Ожидает бэкапа
ludocard-status-none = Нет бэкапа
ludocard-backup = Бэкап
ludocard-restore = Восстановить
ludocard-current-save = Активное сохранение
ludocard-last-backup = Последний бэкап
ludocard-manual-backup = Ручной бэкап
ludocard-loading-library = Загрузка библиотеки игр...
ludocard-monitored-games = Отслеживаемые игры
ludocard-cloud-synced = Синхронизировано с облаком
ludocard-pending-saves-plural = Ожидающие бэкапы
ludocard-search-games = Поиск игр...
ludocard-clear-search = Очистить поиск
ludocard-select-all = Выбрать все
ludocard-platform = Платформа
ludocard-all-platforms = Все платформы
ludocard-sort-by = Сортировка
ludocard-sort-name = По имени (А-Я)
ludocard-sort-recent = Недавно запущенные
ludocard-sort-size = Размер сохранений
ludocard-installed = Установлено
ludocard-pending = Ожидает
ludocard-grid-view = Сетка
ludocard-list-view = Список
ludocard-showing = Отображено
ludocard-of = из
ludocard-game = игра
ludocard-games-plural = игр
ludocard-no-games-found = Игры не найдены
ludocard-adjust-filters-desc = Измените фильтры или отсканируйте папки, чтобы добавить новые игры.
ludocard-starting-backup-for = Запуск бэкапа для
ludocard-backup-completed-for = Бэкап для
ludocard-completed = завершен!
ludocard-completed-fem = завершен!
ludocard-backup-failed-for = Сбой бэкапа для
ludocard-restoring-backup-for = Восстановление бэкапа для
ludocard-restore-completed-for = Восстановление для
ludocard-restore-failed-for = Сбой восстановления для
ludocard-never = Никогда

ludocard-scan-title = Сканирование и добавление
ludocard-scan-desc = Найдите сохранения игр на вашем компьютере
ludocard-auto-search = Автоматический поиск
ludocard-auto-search-desc = Сканирует общие системные папки (Steam, Epic, Документы и AppData) и ваши пользовательские папки на наличие изменений.
ludocard-scanning = Сканирование...
ludocard-start-scan = Запустить сканирование изменений
ludocard-scan-completed = Сканирование завершено
ludocard-scan-completed-desc = Обнаружение изменений завершено.
ludocard-scan-error = Ошибка при сканировании.
ludocard-custom-folder = Пользовательская
ludocard-default-folder = Стандартная
ludocard-folder-added = Папка добавлена в список отслеживания
ludocard-folder-added-success = Папка успешно добавлена!
ludocard-folder-select-error = Ошибка при выборе/добавлении папки.
ludocard-emulator-detected = Выбранная папка принадлежит эмулятору { $emulator }.\n\nХотите добавить её как эмулятор для автоматического отслеживания сохранений?
ludocard-adding-emulator = Добавление эмулятора и сканирование сохранений...
ludocard-emulator-added-success = Эмулятор { $emulator } успешно добавлен! Обнаружено сохранений для { $count } игр.
ludocard-emulator-added-empty = Эмулятор { $emulator } добавлен! Сохранений игр не обнаружено.
ludocard-emulator-add-failed = Не удалось добавить эмулятор: { $error }
ludocard-emulator-added-mock = Эмулятор успешно добавлен! (Демо-режим)
ludocard-emulator-select-error = Ошибка при выборе/добавлении эмулятора.
ludocard-emulator-removed = Эмулятор удален
ludocard-emulator-remove-error = Ошибка при удалении эмулятора.
ludocard-folder-removed = Папка удалена из списка отслеживания
ludocard-folder-remove-error = Ошибка при удалении папки.
ludocard-monitored-folders = Отслеживаемые папки
ludocard-monitored-folders-desc = Корневые директории, постоянно сканируемые на наличие новых сохранений.
ludocard-add-folder = Добавить папку
ludocard-no-folders-detected = Папки с играми не найдены автоматически.
ludocard-click-add-folder-desc = Нажмите «Добавить папку», чтобы выбрать папку библиотеки или эмуляторы.
ludocard-monitoring-active = Мониторинг активен
ludocard-remove-folder = Удалить папку
ludocard-select-new-root = Выбрать новую корневую папку
ludocard-monitored-emulators = Отслеживаемые эмуляторы
ludocard-monitored-emulators-desc = Папки эмуляторов, проверяемые для автоопределения консольных сохранений.
ludocard-add-emulator = Добавить эмулятор
ludocard-no-emulators-configured = Эмуляторы не настроены.
ludocard-click-add-emulator-desc = Нажмите «Добавить эмулятор» для импорта сохранений со Switch, Wii, Wii U, GBA, PS2 и др.
ludocard-saves-integrated = Сохранения интегрированы в библиотеку
ludocard-remove-emulator = Удалить эмулятор
ludocard-add-other-emulator = Добавить другой эмулятор
ludocard-scan-results = Результаты сканирования
ludocard-scan-results-desc = Выберите, для каких игр с новыми или измененными сохранениями сделать бэкап.
ludocard-starting-batch-backup = Запуск пакетного бэкапа для { $count } игр...
ludocard-batch-backup-completed = Пакетный бэкап выбранных игр завершен!
ludocard-batch-backup-failed = Сбой пакетного бэкапа.
ludocard-backup-selected = Создать бэкап выбранных
ludocard-no-new-saves-detected = Изменений не обнаружено. Все игры синхронизированы!
ludocard-new-game = Новая игра
ludocard-changed-save = Изменено

ludocard-cloud-title = Облако и синхронизация
ludocard-cloud-desc = Настройте удаленное резервное копирование сохранений
ludocard-cloud-provider = Облачный провайдер
ludocard-cloud-provider-desc = Выберите, где удаленно хранить ваши бэкапы.
ludocard-auth-status = Статус авторизации и хранилища.
ludocard-connected-as = Подключено как { $account }
ludocard-oauth-authorized = Аккаунт авторизован через OAuth
ludocard-disconnect = Отключить
ludocard-space-used = Использовано места
ludocard-connect-desc = Подключите аккаунт { $provider }, чтобы включить облачный бэкап сохранений.
ludocard-connect-btn = Подключить аккаунт
ludocard-sync-rules = Правила синхронизации
ludocard-sync-rules-desc = Перемещение сохранений между ПК и облаком.
ludocard-auto-upload = Автозагрузка после локального бэкапа
ludocard-auto-upload-desc = Мгновенная отправка в облако после каждого бэкапа.
ludocard-auto-upload-enabled = Автозагрузка включена
ludocard-auto-upload-disabled = Автозагрузка выключена
ludocard-download-if-newer = Скачивать, если облачное сохранение новее
ludocard-download-if-newer-desc = Разрешение конфликтов в пользу более новой версии.
ludocard-auto-download-enabled = Автоматическое скачивание включено
ludocard-auto-download-disabled = Автоматическое скачивание выключено
ludocard-disconnected-provider = { $provider } отключен
ludocard-connected-provider = { $provider } подключен

ludocard-loading = Загрузка...
ludocard-fetching-details = Получение сведений об игре
ludocard-loading-details = Загрузка сведений об игре...
ludocard-details-desc = Подробности и история бэкапов
ludocard-back = Назад
ludocard-select = Выбрать
ludocard-saved-versions = сохраненных версий
ludocard-backup-now = Создать бэкап сейчас
ludocard-restore-latest = Восстановить последнюю
ludocard-open-game-folder-desc = Открыть папку с установленной игрой в Проводнике Windows
ludocard-game-folder = Папка игры
ludocard-open-save-folder-desc = Открыть рабочую папку сохранений
ludocard-save-folder = Папка сохранений
ludocard-open-backup-folder-desc = Открыть папку бэкапов Ludocard
ludocard-backup-folder = Папка бэкапов
ludocard-export-save-desc = Экспортировать сохранение в виде сжатого файла .ludocard для отправки
ludocard-export-save = Экспортировать сохранение (.ludocard)
ludocard-status = Статус
ludocard-saves-on-pc = Сохранения на ПК
ludocard-total-backups = Всего бэкапов
ludocard-quick-preferences = Быстрые настройки
ludocard-save-history = История сохранений
ludocard-config-presets = Пресеты конфигурации
ludocard-saves-timeline = Временная шкала сохранений
ludocard-presets-configs = Пресеты и настройки
ludocard-no-backups-yet = Бэкапов еще нет
ludocard-do-first-backup-desc = Создайте первый бэкап для этой игры, чтобы начать историю версий.
ludocard-active = Активно
ludocard-disabled = Отключено

ludocard-support-title = Поддержать проект
ludocard-support-desc = Помогите сохранить серверы сохранений и настроек в онлайне
ludocard-support-intro-title = Ludocard абсолютно бесплатен!
ludocard-support-intro-desc = Поддержка облачных функций (Save Share Hub и пресеты) сопряжена с ежемесячными расходами на серверы и трафик. Если приложение полезно вам, поддержите проект, чтобы помочь нам оставаться в онлайне!
ludocard-how-to-support = Способы поддержки проекта
ludocard-how-to-support-desc = Выберите удобный способ взноса. Stripe поддерживает кредитные карты и Pix.
ludocard-support-itch = Поддержать на Itch.io
ludocard-support-stripe = Карты / Pix через Stripe
ludocard-support-dest-desc = Все пожертвования полностью направляются на оплату облачных серверов (хостинг и трафик данных).

ludocard-community-title = Save Share HUB
ludocard-community-desc = Делитесь и загружайте файлы сохранений (чекпоинты) сообщества
ludocard-btn-share-checkpoint = Поделиться чекпоинтом
ludocard-repo-disconnected = Публичный репозиторий отключен
ludocard-repo-disconnected-desc = Чтобы загружать чекпоинты сообщества и делиться своими, вам необходимо указать API URL вашего проекта Supabase и публичный Anon Key в настройках.
ludocard-how-to-config = Инструкция по настройке:
ludocard-config-step-1 = Создайте бесплатный проект в Supabase.
ludocard-config-step-2 = Создайте таблицы, выполнив SQL-скрипт из файла supabase/schema.sql.
ludocard-config-step-3 = Введите API URL и публичный Anon Key в настройках Ludocard.
ludocard-checkpoints = Чекпоинты
ludocard-contributors = Авторы
ludocard-search-placeholder = Поиск по названию игры или чекпоинта...
ludocard-sort-popular = Популярные
ludocard-sort-recent-hub = Новые
ludocard-sort-size-hub = Размер
ludocard-syncing-repo = Синхронизация с публичным репозиторием...
ludocard-no-checkpoints-found = Чекпоинты не найдены
ludocard-no-checkpoints-available = Чекпоинты отсутствуют
ludocard-search-terms-desc = Попробуйте изменить поисковый запрос.
ludocard-be-first-desc = Станьте первым, кто поделится сохранением с сообществом!
ludocard-no-desc-provided = Описание не предоставлено.
ludocard-author-by = от
ludocard-zstd-verified = Содержит проверенные метаданные zstd
ludocard-btn-install = Установить
ludocard-btn-installing = Установка...
ludocard-security-sandbox-title = Автоматическая защита Seguro-Crash и Sandbox
ludocard-security-sandbox-desc = При установке чекпоинта сообщества Ludocard автоматически создает резервную копию вашего текущего сохранения перед его заменой. Если что-то пойдет не так, вы всегда сможете восстановить его из истории версий.
ludocard-share-checkpoint-modal = Поделиться чекпоинтом
ludocard-publish-progress-desc = Опубликуйте ваш файл сохранения в сообществе.
ludocard-save-game-label = Игра сохранения *
ludocard-search-installed-game = Введите название установленной игры...
ludocard-backup-version-label = Версия бэкапа *
ludocard-no-local-backups-desc = Локальные бэкапы для этой игры еще не создавались. Создайте бэкап в карточке игры.
ludocard-checkpoint-title-label = Название чекпоинта *
ludocard-checkpoint-title-placeholder = Например: Перед Маленией или 100% Прохождение (100 Уровень)
ludocard-checkpoint-author-label = Имя автора
ludocard-checkpoint-author-placeholder = Например: Аноним
ludocard-checkpoint-desc-label = Описание / Дополнительные примечания
ludocard-checkpoint-desc-placeholder = Опишите билд, уровень, важные предметы или момент прохождения.
ludocard-checkpoint-tags-label = Теги чекпоинта
ludocard-btn-cancel = Отмена
ludocard-btn-publishing = Публикация...
ludocard-btn-publish = Опубликовать чекпоинт
ludocard-detail-modal-desc = Просмотр полных метаданных чекпоинта.
ludocard-btn-close = Закрыть
ludocard-btn-download-install = Скачать и установить
ludocard-detail-title-label = Название чекпоинта:
ludocard-detail-desc-label = Описание прогресса:
ludocard-detail-tags-label = Теги:
ludocard-detail-size-label = Сжатый размер:
ludocard-detail-downloads-label = Всего скачиваний:
ludocard-detail-author-label = Отправитель:
ludocard-detail-date-label = Дата отправки:
ludocard-date-today = Сегодня
ludocard-date-yesterday = Вчера
ludocard-date-days-ago = дн. назад
ludocard-date-weeks-ago = нед. назад
ludocard-date-locale = ru-RU

ludocard-presethub-title = Preset Share HUB
ludocard-presethub-desc = Открывайте для себя и делитесь графическими настройками и раскладками управления
ludocard-btn-share-preset = Поделиться пресетом
ludocard-presethub-disconnected = Репозиторий пресетов отключен
ludocard-presethub-disconnected-desc = Чтобы загружать пресеты сообщества и делиться своими, вам необходимо указать API URL вашего проекта Supabase и публичный Anon Key в настройках.
ludocard-presets = Пресеты
ludocard-preset-search-placeholder = Поиск по названию игры, пресета или железу (например, RTX 4070)...
ludocard-syncing-presets = Синхронизация пресетов...
ludocard-no-presets-found = Графические пресеты не найдены
ludocard-search-terms-desc-preset = Попробуйте изменить поисковый запрос.
ludocard-badge-official = Официальный
ludocard-gpu = Видеокарта (GPU)
ludocard-approval = Рейтинг одобрения
ludocard-useful = Useful
ludocard-useless = Useless
ludocard-report-preset = Пожаловаться на пресет
ludocard-btn-undo = Отменить
ludocard-btn-inject = Применить
ludocard-btn-injecting = Применение...
ludocard-not-installed = Не установлена
ludocard-security-safety-title = Безопасность гарантирована Seguro-Crash
ludocard-security-safety-desc = При скачивании любого графического пресета из HUB Ludocard делает резервную копию ваших предыдущих настроек. Ваши файлы сохранений с прогрессом остаются нетронутыми.
ludocard-share-preset-modal-title = Поделиться графическим пресетом
ludocard-share-preset-modal-desc = Отправьте локальный графический пресет в сообщество.
ludocard-preset-game-label = Игра пресета *
ludocard-search-installed-game-preset = Поиск установленной игры...
ludocard-choose-local-preset-label = Выбрать локальный пресет *
ludocard-no-local-presets-desc = Локальные пресеты для этой игры не найдены. Перейдите в карточку игры и создайте локальный пресет!
ludocard-preset-title-label = Название пресета *
ludocard-preset-creator-label = Автор / Создатель
ludocard-preset-desc-label = Описание / Примечания пресета
ludocard-preset-tags-label = Теги пресета
ludocard-preset-hardware-label = Железо автора (Заполняется автоматически на основе локального пресета):
ludocard-cpu = Процессор (CPU)
ludocard-ram = ОЗУ (RAM)
ludocard-btn-publish-preset = Опубликовать пресет
ludocard-detail-preset-title = Название пресета:
ludocard-detail-preset-desc = Описание / Оптимизации:
ludocard-detail-author-specs = Железо автора:

ludocard-tag-desc-100 = Игра пройдена на 100%, разблокированы все достижения, предметы и коллекционные вещи.
ludocard-tag-desc-dlc1 = Прогресс сфокусирован на подготовке или готовности к запуску первого DLC.
ludocard-tag-desc-dlc2 = Прогресс сфокусирован на подготовке или готовности к запуску второго DLC.
ludocard-tag-desc-ngplus = Игра готова к запуску или уже запущена в режиме "Новая игра+".
ludocard-tag-desc-vanilla = Чистый прогресс оригинальной игры без модификаторов, модов или читов.
ludocard-tag-desc-modded = Прогресс получен с использованием модификаций (модов), влияющих на геймплей.
ludocard-tag-desc-bossprep = Сохранение создано непосредственно перед важным боссом в игре.
ludocard-tag-desc-starter = Сохранение в самом начале игры с накопленными ресурсами или пропущенным обучением.
ludocard-tag-desc-cleanstart = Сохранение сразу после создания персонажа или вступления, готовое к старту игры без обучения.
ludocard-tag-desc-midgame = Сохранение на середине прохождения сюжетной кампании (отлично подходит для тех, кто потерял сохранения).
ludocard-tag-desc-postgame = Сюжет пройден, идеальный вариант для сражений с секретными боссами, добивания достижений или побочных активностей.
ludocard-tag-desc-opbuild = Сохранение с персонажем, имеющим максимально сильное снаряжение, уровень и сборку (Overpowered).
ludocard-tag-desc-unlimitedcash = Сохранение с максимальным или бесконечным количеством игровой валюты, монет или ресурсов.
ludocard-tag-desc-allcollectibles = Сохранение с полностью собранными коллекционными предметами и выполненными второстепенными задачами.
ludocard-tag-desc-hardcore = Сохранение на максимальном уровне сложности или с активированной перманентной смертью (хардкор).
ludocard-tag-desc-speedrunready = Идеальное сохранение для тренировки отдельных сегментов спидрана или находящееся на быстрейшем маршруте.
ludocard-tag-desc-legit = Честное прохождение игры без читов, кодов и использования багов (гличей).
ludocard-preset-tag-desc-perf = Оптимизации, направленные на прирост кадров в секунду (FPS) и плавность.
ludocard-preset-tag-desc-quality = Настройки, сфокусированные на достижении максимального качества графики.
ludocard-preset-tag-desc-balanced = Оптимальный баланс между качеством картинки и производительностью (FPS).
ludocard-preset-tag-desc-deck = Настройки, оптимизированные под экран и энергопотребление портативной консоли Steam Deck.
ludocard-preset-tag-desc-potato = Для запуска игры на очень старых ПК или слабых ноутбуках.
ludocard-preset-tag-desc-controls = Персональная настройка кнопок управления, геймпада или горячих клавиш.
ludocard-preset-tag-desc-rt = Тонкая настройка графики с включенной трассировкой лучей для сохранения комфортного FPS.
ludocard-preset-tag-desc-4k = Настройки, оптимизированные под запуск на 4K-мониторах и телевизорах высокого разрешения.
ludocard-preset-tag-desc-vr = Настройки, подобранные для обеспечения стабильной кадровой частоты в виртуальной реальности.

ludocard-schedule-auto-routine = Расписание автосохранений
ludocard-schedule-auto-routine-desc = Задайте время для создания автоматических бэкапов.
ludocard-schedule-by-interval = По интервалу
ludocard-schedule-by-days = Дни недели
ludocard-schedule-backup-every = Создавать бэкап каждые
ludocard-schedule-1-hour = 1 час
ludocard-schedule-3-hours = 3 часа
ludocard-schedule-6-hours = 6 часов
ludocard-schedule-12-hours = 12 часов
ludocard-schedule-24-hours = 24 часа
ludocard-schedule-at-time = В назначенное время
ludocard-schedule-games-in-schedule = Игры в расписании
ludocard-schedule-games-in-schedule-desc = Выберите игры, которые будут сохраняться автоматически по этому расписанию.
ludocard-schedule-btn-save = Сохранить расписание
ludocard-schedule-saved-toast = Расписание успешно сохранено

ludocard-day-sun = Вс
ludocard-day-mon = Пн
ludocard-day-tue = Вт
ludocard-day-wed = Ср
ludocard-day-thu = Чт
ludocard-day-fri = Пт
ludocard-day-sat = Сб

ludocard-notification-alerts = Оповещения и уведомления
ludocard-notification-alerts-desc = Выберите, как вы хотите получать уведомления о бэкапах.
ludocard-notification-windows = Системные уведомления Windows
ludocard-notification-windows-desc = Уведомлять при успешном завершении резервного копирования.
ludocard-notification-toast-enabled = Уведомления включены
ludocard-notification-toast-disabled = Уведомления отключены
ludocard-notification-fail-alerts = Оповещения об ошибках
ludocard-notification-fail-alerts-desc = Немедленно уведомлять при сбое резервного копирования.
ludocard-notification-toast-fail-enabled = Оповещения об ошибках включены
ludocard-notification-toast-fail-disabled = Оповещения об ошибках отключены
ludocard-notification-sounds = Звуки оповещения
ludocard-notification-sounds-desc = Воспроизводить звук при успешном завершении или ошибке бэкапа.
ludocard-notification-toast-sounds-enabled = Звуки включены
ludocard-notification-toast-sounds-disabled = Звуки отключены


