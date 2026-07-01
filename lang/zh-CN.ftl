ludusavi = Ludusavi
language = 语言
game-name = 名称
total-games = 游戏
file-size = 大小
file-location = 位置
overall = 总体
status = 状态
cli-unrecognized-games = 没有这些游戏的信息：
cli-unable-to-request-confirmation = 无法请求确认。
    .winpty-workaround = 若您正在使用 Bash 模拟器（例如 Git Bash），请尝试运行 winpty。
cli-backup-id-with-multiple-games = 恢复多个游戏时无法指定备份 ID。
cli-invalid-backup-id = 无效的备份 ID。
badge-failed = 已失败
badge-duplicates = 复制为副本
badge-duplicated = 已复制为副本
badge-ignored = 已忽略
badge-redirected-from = 来自：{ $path }
badge-redirecting-to = 到： { $path }
some-entries-failed = 有些条目无法处理；详情请参阅输出中的 { badge-failed }。请仔细检查您是否可以访问这些文件，或者它们的路径是否太长。
cli-game-line-item-redirected = 重定向自：{ $path }
cli-game-line-item-redirecting = 重定向到：{ $path }
button-backup = 备份
button-preview = 预览
button-restore = 恢复
button-nav-backup = 备份模式
button-nav-restore = 恢复模式
button-nav-custom-games = 自定义游戏
button-nav-other = 其他
button-add-game = 添加游戏
button-continue = 继续
button-cancel = 取消
button-cancelling = 取消中...
button-okay = 好的
button-select-all = 全选
button-deselect-all = 全不选
button-enable-all = 全部启用
button-disable-all = 全部禁用
button-customize = 自定义
button-exit = 退出
button-comment = 备注
button-lock = 锁定
button-unlock = 解锁
# This opens a download page.
button-get-app = 获取 { $app }
button-validate = 验证
button-override-manifest = 覆盖清单
button-extend-manifest = 扩展清单
button-sort = 排序
button-download = 下载
button-upload = 上传
button-ignore = 忽略
no-roots-are-configured = 添加一些根，以备份甚至更多的数据。
config-is-invalid = 错误：配置文件无效。
manifest-is-invalid = 错误：manifest 文件无效。
manifest-cannot-be-updated = 错误：无法检查 manifest 文件的更新。您的互联网连接是否已断开？
cannot-prepare-backup-target = 错误：无法准备备份目标（创建或清空文件夹）。若您在文件浏览器中打开了该文件夹，请尝试关闭它：{ $path }
restoration-source-is-invalid = 错误：恢复源无效（不存在或非目录）。请仔细检查位置：{ $path }
registry-issue = 错误：一些注册表条目被跳过。
unable-to-browse-file-system = 错误：无法浏览您的系统。
unable-to-open-directory = 错误：无法打开目录：
unable-to-open-url = 错误：无法打开链接：
unable-to-configure-cloud = 无法配置云备份
unable-to-synchronize-with-cloud = 无法与云备份同步
cloud-synchronize-conflict = 你的本地文件和云备份发生冲突，执行上传或下载以解决这个问题。
command-unlaunched = 命令未启动： { $command }
command-terminated = 命令突然终止： { $command }
command-failed = 命令失败，错误代码 { $code }: { $command }
processed-games = { $total-games } 游戏
processed-games-subset = { $processed-games }，共 { $total-games } 游戏
processed-size-subset = { $total-size }中的{ $processed-size }
field-backup-target = 备份到:
field-restore-source = 还原自
field-custom-files = 路径：
field-custom-registry = 注册表
field-sort = 排序：
field-redirect-source =
    .placeholder = 源 (原始位置)
field-redirect-target =
    .placeholder = 目标 (新位置)
field-roots = 根目录：
field-backup-excluded-items = 备份排除：
field-redirects = 文件夹重定向
# This appears next to the number of full backups that you'd like to keep.
# A full backup includes all save files for a game.
field-retention-full = 完整备份
# This appears next to the number of differential backups that you'd like to keep.
# A differential backup includes only the files that have changed since the last full backup.
field-retention-differential = 差异备份
field-backup-format = 格式：
field-backup-compression = 压缩：
# The compression level determines how much compresison we perform.
field-backup-compression-level = 压缩等级：
label-manifest = 预设列表
# This shows the time when we checked for an update to the manifest.
label-checked = 已检查
# This shows the time when we found an update to the manifest.
label-updated = 已更新
label-new = 新的存档
label-removed = 删除
label-comment = 备注
label-unchanged = 未改变
label-backup = 备份
label-scan = 扫描
label-filter = 筛选
label-unique = 单一文件
label-complete = 全部
label-partial = 部分
label-enabled = 启用
label-disabled = 禁用
# https://en.wikipedia.org/wiki/Thread_(computing)
label-threads = 线程
label-cloud = 云备份
# A "remote" is what Rclone calls cloud systems like Google Drive.
label-remote = 远程
label-remote-name = 远程名称
label-folder = 目录
# An executable file
label-executable = 可执行文件
# Options given to a command line program
label-arguments = 参数
label-url = 链接地址
# https://en.wikipedia.org/wiki/Host_(network)
label-host = 主机
# https://en.wikipedia.org/wiki/Port_(computer_networking)
label-port = 端口
label-username = 用户名
label-password = 密码
# This is a specific website or service that provides some cloud functionality.
# For example, Nextcloud and Owncloud are providers of WebDAV services.
label-provider = 提供方
label-custom = 自定义
label-none = 无
label-change-count = 更改︰ { $total }
label-unscanned = 未扫描
# This refers to a local file on the computer
label-file = 文件
label-game = 游戏
# Aliases are alternative titles for the same game.
label-alias = 别名
label-original-name = 原始名称
# Which manifest a game's data came from
label-source = 游戏数据来源
# This refers to the main Ludusavi manifest: https://github.com/mtkennerly/ludusavi-manifest
label-primary-manifest = 主要清单
# This refers to how we integrate a custom game with the manifest data.
label-integration = 集成方式
# This is a folder name where a specific game is installed
label-installed-name = 安装名称
store-ea = EA
store-epic = Epic
store-gog = GOG
store-gog-galaxy = GOG Galaxy
store-heroic = Heroic
store-legendary = Legendary
store-lutris = Lutris
store-microsoft = 微软商店
store-origin = Origin
store-prime = 亚马逊 Prime Gaming
store-steam = Steam
store-uplay = 育碧 Uplay
store-other-home = 主文件夹
# This would be a folder acting as a virtual C: drive, created by Wine.
store-other-wine = Wine prefix
# This would be a folder with typical Windows system folders,
# like "Program Files (x86)" and "Users".
store-other-windows = 其它Windows商店
# This would be a folder with typical Linux system folders,
# like "home" and "opt".
store-other-linux = 其它Linux商店
# This would be a folder with typical Mac system folders,
# like "Applications" and "Users".
store-other-mac = 其它Mac商店
store-other = 其他
backup-format-simple = 普通
backup-format-zip = Zip 文件
compression-none = 不进行压缩
# "Deflate" is a proper noun: https://en.wikipedia.org/wiki/Deflate
compression-deflate = Deflate
compression-bzip2 = Bzip2
compression-zstd = Zstd
theme = 主题
theme-light = 亮
theme-dark = 暗
redirect-bidirectional = 双向
reverse-redirects-when-restoring = 恢复时反转重定向顺序
show-disabled-games = 显示禁用的游戏
show-unchanged-games = 显示未修改的游戏
show-unscanned-games = 显示未扫描的游戏
override-max-threads = 覆盖最大线程
synchronize-automatically = 自动同步
prefer-alias-display = 显示别名而不是原始名称
skip-unconstructive-backups = 当数据被删除而非添加或更新时，跳过备份
explanation-for-exclude-store-screenshots = 在备份中，排除特定商店的屏幕截图
explanation-for-exclude-cloud-games = 不要在这些平台上备份云支持的游戏
consider-doing-a-preview = 如果您还没有预览，请考虑先进行预览，防止发生任何意料之外的结果。
confirm-backup =
    确定要继续备份吗？ { $path-action ->
        [merge] 新保存的数据将被合并到目标文件夹中：
       *[create] 目标文件夹将被创建：
    }
confirm-restore =
    您确定要继续恢复吗？
    这将会覆盖当前备份的所有文件：
confirm-cloud-upload =
    你想要用本地文件替换云备份文件吗？
    云备份文件({ $cloud-path }) 将成为本地文件的副本({ $local-path })。
    云备份的文件将根据需求在必要时更新或删除。
confirm-cloud-download =
    你想要用云备份文件替换本地文件吗？
    本地文件({ $local-path }) 将成为云备份文件的副本({ $cloud-path })。
    本地的文件将根据需求在必要时更新或删除。
confirm-add-missing-roots = 添加这些根目录吗？
no-missing-roots = 未找到其他根目录。
loading = 正在加载...
preparing-backup-target = 正在准备备份文件夹...
updating-manifest = 正在更新 Manifest 文件...
no-cloud-changes = 没有需要同步的更改
backups-are-valid = 您的备份是有效的。
backups-are-invalid =
    这些游戏的备份似乎无效。
    您想为这些游戏创建新的完全备份吗？
saves-found = 发现已有的存档。
no-saves-found = 未找到存档。
# This is tacked on to form something like "Back up (no confirmation)",
# meaning we would perform an action without asking the user if they're sure.
suffix-no-confirmation = 不进行确认
# This is shown when a setting will only take effect after closing and reopening Ludusavi.
suffix-restart-required = 需要重启
prefix-error = 错误： { $message }
prefix-warning = 警告： { $message }
cloud-app-unavailable = 云备份已禁用，因为 { $app } 不可用。
cloud-not-configured = 云备份已禁用，因为没有配置云远程设置。
cloud-path-invalid = 云备份已禁用，因为备份路径无效。
game-is-unrecognized = Ludusavi 不能识别此游戏
game-has-nothing-to-restore = 此游戏没有备份可以恢复。
launch-game-after-error = 仍然要启动游戏吗？
game-did-not-launch = 游戏启动失败。
backup-is-newer-than-current-data = 备份数据新于当前数据。
backup-is-older-than-current-data = 备份数据旧于当前数据。
back-up-specific-game =
    .confirm = 要备份 { $game } 的存档数据吗？
    .failed = 备份 { $game } 的存档数据失败
restore-specific-game =
    .confirm = 要恢复 { $game } 的存档数据吗？
    .failed = 恢复 { $game } 的存档数据失败
new-version-check = 自动检查应用程序更新
new-version-available = 应用程序更新可用：{ $version }. 是否要查看发行说明？
custom-game-will-override = 这个自定义游戏会覆盖一个清单项
custom-game-will-extend = 这个自定义游戏会扩展一个清单项
operation-will-only-include-listed-games = 这将仅处理当前列出的游戏

ludocard-library = 游戏库
ludocard-scan-and-add = 扫描与添加
ludocard-cloud-and-sync = 云与同步
ludocard-save-share-hub = 存档分享中心
ludocard-preset-share-hub = 配置分享中心
ludocard-settings = 设置
ludocard-support-project = 支持项目
ludocard-library-status = 游戏库状态
ludocard-games = 游戏数
ludocard-language = 语言
ludocard-language-desc = 界面显示语言。
ludocard-sidebar-subtitle = 存档备份管理器
ludocard-navigation = 导航
ludocard-stored-saves = 已存储存档
ludocard-pending-saves = 待处理
ludocard-downloading-covers = 正在下载封面...
ludocard-settings-desc = 应用偏好设置与行为
ludocard-dashboard-desc = 管理并保护您的游戏存档

ludocard-file-watcher = 存档监视器 (File Watcher)
ludocard-file-watcher-desc = 监视存档文件更改，在游戏关闭时自动进行备份。
ludocard-start-with-windows = 随 Windows 启动
ludocard-start-with-windows-desc = 电脑开机时自动启动并最小化至系统托盘。
ludocard-system-tray = 最小化至托盘 (System Tray)
ludocard-system-tray-desc = 点击关闭时最小化至系统托盘，保持后台监视运行。
ludocard-portable = 便携模式 (Portable Mode)
ludocard-portable-desc = 将所有配置、清单和备份保存在可执行文件目录下（非常适合U盘）。
ludocard-theme = 主题
ludocard-theme-desc = 应用程序的界面外观。
ludocard-theme-dark = 深色
ludocard-theme-light = 浅色
ludocard-theme-system = 跟随系统
ludocard-backup-dir = 备份目录
ludocard-backup-dir-desc = 本地游戏存档备份的存储路径。

ludocard-rclone-path = Rclone 可执行文件路径
ludocard-rclone-path-desc = 用于云端同步的 Rclone 可执行文件的路径。
ludocard-cloud-folder = 云端远程文件夹
ludocard-cloud-folder-desc = 用于同步文件的远程文件夹名称。
ludocard-rclone-args = Rclone 附加参数
ludocard-rclone-args-desc = 直接传递给 rclone 的可选命令和标志。
ludocard-supabase-url = Supabase URL (社区仓库)
ludocard-supabase-url-desc = 用于社区标签页的 Supabase 项目 API URL。
ludocard-supabase-key = Supabase 匿名密钥 (Anon Key)
ludocard-supabase-key-desc = 用于表单匿名身份验证的公共 (anon) 密钥。
ludocard-btn-save-settings = 保存设置

ludocard-tab-general = 通用
ludocard-tab-schedule = 调度计划
ludocard-tab-notifications = 通知提示
ludocard-general-preferences = 通用偏好设置
ludocard-general-preferences-desc = 应用程序路径和基本行为。

ludocard-status-synchronized = 已同步
ludocard-status-pending = 待备份
ludocard-status-none = 未备份
ludocard-backup = 备份
ludocard-restore = 还原
ludocard-current-save = 当前存档
ludocard-last-backup = 上次备份
ludocard-manual-backup = 手动备份
ludocard-loading-library = 正在加载游戏库...
ludocard-monitored-games = 已监控游戏
ludocard-cloud-synced = 云同步
ludocard-pending-saves-plural = 待处理备份
ludocard-search-games = 搜索游戏...
ludocard-clear-search = 清空搜索
ludocard-select-all = 全选
ludocard-platform = 平台
ludocard-all-platforms = 所有平台
ludocard-sort-by = 排序方式
ludocard-sort-name = 名称 (A-Z)
ludocard-sort-recent = 最近玩过
ludocard-sort-size = 存档大小
ludocard-installed = 已安装
ludocard-pending = 待处理
ludocard-grid-view = 网格视图
ludocard-list-view = 列表视图
ludocard-showing = 显示
ludocard-of = /
ludocard-game = 个游戏
ludocard-games-plural = 个游戏
ludocard-no-games-found = 未找到游戏
ludocard-adjust-filters-desc = 调整过滤器或扫描文件夹以添加新游戏。
ludocard-starting-backup-for = 开始备份
ludocard-backup-completed-for = 备份
ludocard-completed = 已完成！
ludocard-completed-fem = 已完成！
ludocard-backup-failed-for = 备份失败：
ludocard-restoring-backup-for = 正在还原备份：
ludocard-restore-completed-for = 还原
ludocard-restore-failed-for = 还原失败：
ludocard-never = 从未

ludocard-scan-title = 扫描与添加
ludocard-scan-desc = 在您的电脑上查找游戏存档
ludocard-auto-search = 自动搜索
ludocard-auto-search-desc = 扫描系统常见文件夹（Steam、Epic、文档和 AppData）以及您的自定义文件夹以寻找新存档或更改。
ludocard-scanning = 正在扫描...
ludocard-start-scan = 开始扫描更改
ludocard-scan-completed = 扫描完成
ludocard-scan-completed-desc = 更改检测已结束。
ludocard-scan-error = 扫描时发生错误。
ludocard-custom-folder = 自定义
ludocard-default-folder = 默认
ludocard-folder-added = 已添加文件夹到监控
ludocard-folder-added-success = 文件夹添加成功！
ludocard-folder-select-error = 选择/添加文件夹时出错。
ludocard-emulator-detected = 所选文件夹属于模拟器 { $emulator }。\n\n是否要将其添加为模拟器以自动跟踪您的游戏存档？
ludocard-adding-emulator = 正在添加模拟器并扫描存档...
ludocard-emulator-added-success = 模拟器 { $emulator } 添加成功！在存档文件夹中检测到 { $count } 个游戏。
ludocard-emulator-added-empty = 模拟器 { $emulator } 已添加！文件夹中未检测到任何游戏存档。
ludocard-emulator-add-failed = 添加模拟器失败：{ $error }
ludocard-emulator-added-mock = 模拟器添加成功！(模拟)
ludocard-emulator-select-error = 选择/添加模拟器时出错。
ludocard-emulator-removed = 模拟器已移除
ludocard-emulator-remove-error = 移除模拟器时出错。
ludocard-folder-removed = 已从监控中移除文件夹
ludocard-folder-remove-error = 移除文件夹时出错。
ludocard-monitored-folders = 已监控文件夹
ludocard-monitored-folders-desc = 持续监控以寻找新存档的根目录。
ludocard-add-folder = 添加文件夹
ludocard-no-folders-detected = 未自动检测到游戏文件夹。
ludocard-click-add-folder-desc = 点击“添加文件夹”以选择库文件夹或模拟器。
ludocard-monitoring-active = 监控已启用
ludocard-remove-folder = 移除文件夹
ludocard-select-new-root = 选择新根文件夹
ludocard-monitored-emulators = 已监控模拟器
ludocard-monitored-emulators-desc = 监控以自动检测主机存档的模拟器目录。
ludocard-add-emulator = 添加模拟器
ludocard-no-emulators-configured = 未配置任何模拟器。
ludocard-click-add-emulator-desc = 点击“添加模拟器”以导入 Switch、Wii、Wii U、GBA、PS2 等的存档。
ludocard-saves-integrated = 存档已整合到库中
ludocard-remove-emulator = 移除模拟器
ludocard-add-other-emulator = 添加另一个模拟器
ludocard-scan-results = 扫描结果
ludocard-scan-results-desc = 选择您要备份哪些具有新存档或已更改存档的游戏。
ludocard-starting-batch-backup = 正在开始 { $count } 个游戏的批量备份...
ludocard-batch-backup-completed = 所选游戏的备份已完成！
ludocard-batch-backup-failed = 批量备份失败。
ludocard-backup-selected = 备份所选内容
ludocard-no-new-saves-detected = 未检测到新存档或更改。所有游戏均已同步！
ludocard-new-game = 新游戏
ludocard-changed-save = 已更改

ludocard-cloud-title = 云端与同步
ludocard-cloud-desc = 配置您的存档远程备份
ludocard-cloud-provider = 云存储服务商
ludocard-cloud-provider-desc = 选择您的备份远程存储位置。
ludocard-auth-status = 身份验证和存储状态。
ludocard-connected-as = 已连接为 { $account }
ludocard-oauth-authorized = 已通过 OAuth 授权账户
ludocard-disconnect = 断开连接
ludocard-space-used = 已用空间
ludocard-connect-desc = 连接您的 { $provider } 账户以启用存档远程备份。
ludocard-connect-btn = 连接账户
ludocard-sync-rules = 同步规则
ludocard-sync-rules-desc = 存档在电脑与云端之间的流动方式。
ludocard-auto-upload = 本地备份后自动上传
ludocard-auto-upload-desc = 每次备份后立即上传到云端。
ludocard-auto-upload-enabled = 自动上传已启用
ludocard-auto-upload-disabled = 自动上传已禁用
ludocard-download-if-newer = 若云端存档更新则下载
ludocard-download-if-newer-desc = 优先考虑较新版本以解决冲突。
ludocard-auto-download-enabled = 自动下载已启用
ludocard-auto-download-disabled = 自动下载已禁用
ludocard-disconnected-provider = { $provider } 已断开连接
ludocard-connected-provider = { $provider } 已连接

ludocard-loading = 正在加载...
ludocard-fetching-details = 正在获取游戏详情
ludocard-loading-details = 正在加载游戏详情...
ludocard-details-desc = 备份详情及历史记录
ludocard-back = 返回
ludocard-select = 选择
ludocard-saved-versions = 个已保存版本
ludocard-backup-now = 立即备份
ludocard-restore-latest = 还原最新版本
ludocard-open-game-folder-desc = 在 Windows 资源管理器中打开游戏安装文件夹
ludocard-game-folder = 游戏文件夹
ludocard-open-save-folder-desc = 打开存放活动存档的文件夹
ludocard-save-folder = 存档文件夹
ludocard-open-backup-folder-desc = 打开 Ludocard 存档备份文件夹
ludocard-backup-folder = 备份文件夹
ludocard-export-save-desc = 导出存档为压缩的 .ludocard 文件以供分享
ludocard-export-save = 导出存档 (.ludocard)
ludocard-status = 状态
ludocard-saves-on-pc = 本地存档
ludocard-total-backups = 备份总计
ludocard-quick-preferences = 快速首选项
ludocard-save-history = 存档历史
ludocard-config-presets = 配置预设
ludocard-saves-timeline = 存档时间线
ludocard-presets-configs = 预设与配置
ludocard-no-backups-yet = 暂无备份
ludocard-do-first-backup-desc = 为此游戏创建首个备份以开始时间线。
ludocard-active = 已启用
ludocard-disabled = 已禁用

ludocard-support-title = 支持该项目
ludocard-support-desc = 帮助保持社区存档和配置预设服务器的在线状态
ludocard-support-intro-title = Ludocard 是完全免费的！
ludocard-support-intro-desc = 我们的云功能（Save Share Hub 和预设）会产生每月的服务器和流量费用。如果本应用对您有所帮助，请考虑支持我们以协助维持其在线运行！
ludocard-how-to-support = 如何支持该项目
ludocard-how-to-support-desc = 选择您喜欢的捐赠方式。Stripe 支持信用卡和国内 PIX。
ludocard-support-itch = 在 Itch.io 上支持我们
ludocard-support-stripe = 通过 Stripe 进行银行卡 / PIX 捐赠
ludocard-support-dest = 资金用途说明
ludocard-support-dest-desc = 所有捐赠将全额用于维护云服务器（托管 and 数据流量）。

ludocard-community-title = Save Share HUB
ludocard-community-desc = 分享和下载社区存档 Checkpoint
ludocard-btn-share-checkpoint = 分享 Checkpoint
ludocard-repo-disconnected = 社区仓库未连接
ludocard-repo-disconnected-desc = 要加载社区 Checkpoint 并分享您自己的 Checkpoint，您需要在设置中配置 Supabase URL 和公共 Anon Key。
ludocard-how-to-config = 如何配置：
ludocard-config-step-1 = 在 Supabase 上创建一个免费项目。
ludocard-config-step-2 = 通过运行 supabase/schema.sql 中的 SQL 脚本来创建表。
ludocard-config-step-3 = 在 Ludocard 设置中插入 API URL 和公共 Anon Key。
ludocard-checkpoints = Checkpoints
ludocard-contributors = 贡献者
ludocard-search-placeholder = 按游戏或 Checkpoint 搜索...
ludocard-sort-popular = 热门
ludocard-sort-recent-hub = 最近
ludocard-sort-size-hub = 大小
ludocard-syncing-repo = 正在与公共仓库同步...
ludocard-no-checkpoints-found = 未找到 Checkpoint
ludocard-no-checkpoints-available = 没有可用的 Checkpoint
ludocard-search-terms-desc = 尝试使用其他词进行搜索。
ludocard-be-first-desc = 成为第一个分享社区存档的人！
ludocard-no-desc-provided = 未提供详细说明。
ludocard-author-by = 由
ludocard-zstd-verified = 包含已验证的 zstd 元数据
ludocard-btn-install = 安装
ludocard-btn-installing = 正在安装...
ludocard-security-sandbox-title = 自动 Seguro-Crash 和沙盒安全
ludocard-security-sandbox-desc = 在安装社区 Checkpoint 时，Ludocard 会在覆盖前自动为您的当前存档创建安全备份。如果发生任何错误，只需从历史记录中恢复之前的备份即可。
ludocard-share-checkpoint-modal = 分享 Checkpoint
ludocard-publish-progress-desc = 向社区发布您的进度文件。
ludocard-save-game-label = 存档游戏 *
ludocard-search-installed-game = 输入以搜索已安装的游戏...
ludocard-backup-version-label = 备份版本 *
ludocard-no-local-backups-desc = 此游戏尚未进行本地备份。请先在游戏卡中创建备份。
ludocard-checkpoint-title-label = Checkpoint 标题 *
ludocard-checkpoint-title-placeholder = 例如：玛莲妮亚前 或 100% 完美存档（100 级）
ludocard-checkpoint-author-label = 作者名称
ludocard-checkpoint-author-placeholder = 例如：匿名
ludocard-checkpoint-desc-label = 说明 / 附加说明
ludocard-checkpoint-desc-placeholder = 描述诸如 Build、等级、重要物品或进度点等细节。
ludocard-checkpoint-tags-label = Checkpoint 标签
ludocard-btn-cancel = 取消
ludocard-btn-publishing = 正在发布...
ludocard-btn-publish = 发布 Checkpoint
ludocard-detail-modal-desc = 查看完整的 Checkpoint 元数据。
ludocard-btn-close = 关闭
ludocard-btn-download-install = 下载并安装
ludocard-detail-title-label = Checkpoint 标题：
ludocard-detail-desc-label = 进度说明：
ludocard-detail-tags-label = 标记：
ludocard-detail-size-label = 压缩大小：
ludocard-detail-downloads-label = 总下载量：
ludocard-detail-author-label = 上传者：
ludocard-detail-date-label = 上传时间：
ludocard-date-today = 今天
ludocard-date-yesterday = 昨天
ludocard-date-days-ago = 天前
ludocard-date-weeks-ago = 周前
ludocard-date-locale = zh-CN

ludocard-presethub-title = Preset Share HUB
ludocard-presethub-desc = 探索和分享来自社区的图形和控制器优化
ludocard-btn-share-preset = 分享预设
ludocard-presethub-disconnected = 预设仓库未连接
ludocard-presethub-disconnected-desc = 要加载社区预设并分享您自己的预设，您需要在设置中配置 Supabase URL 和公共 Anon Key。
ludocard-presets = 预设
ludocard-preset-search-placeholder = 按游戏、标题或硬件搜索（例如 RTX 4070）...
ludocard-syncing-presets = 正在同步预设...
ludocard-no-presets-found = 未找到图形预设
ludocard-search-terms-desc-preset = 尝试重置您的搜索条件。
ludocard-badge-official = 官方
ludocard-gpu = GPU
ludocard-approval = 好评率
ludocard-useful = 挺好
ludocard-useless = 没用
ludocard-report-preset = 举报预设
ludocard-btn-undo = 撤销
ludocard-btn-inject = 注入
ludocard-btn-injecting = 正在注入...
ludocard-not-installed = 未安装
ludocard-security-safety-title = 拥有 Seguro-Crash 安全保障
ludocard-security-safety-desc = 从 HUB 下载任何图形预设时，Ludocard 都会备份您以前的设置。您的进度存档不会受到影响。
ludocard-share-preset-modal-title = 分享图形预设
ludocard-share-preset-modal-desc = 将本地图形预设发送到社区。
ludocard-preset-game-label = 预设游戏 *
ludocard-search-installed-game-preset = 搜索已安装的游戏...
ludocard-choose-local-preset-label = 选择本地预设 *
ludocard-no-local-presets-desc = 此游戏没有保存的本地预设。请先去游戏选项卡中创建一个本地预设！
ludocard-preset-title-label = 预设标题 *
ludocard-preset-creator-label = 作者 / 创建者
ludocard-preset-desc-label = 说明 / 预设说明
ludocard-preset-tags-label = 预设标签
ludocard-preset-hardware-label = 作者硬件（从本地预设自动填充）：
ludocard-cpu = CPU
ludocard-ram = 内存 (RAM)
ludocard-btn-publish-preset = 发布预设
ludocard-detail-preset-title = 预设标题：
ludocard-detail-preset-desc = 说明 / 优化：
ludocard-detail-author-specs = 作者配置：

ludocard-tag-desc-100 = 游戏 100% 完成，所有成就、道具和收集品全部解锁。
ludocard-tag-desc-dlc1 = 重点针对或已准备好开始第一个 DLC。
ludocard-tag-desc-dlc2 = 重点针对或已准备好开始第二个 DLC。
ludocard-tag-desc-ngplus = 准备好或已经在新游戏+模式中开始游戏。
ludocard-tag-desc-vanilla = 纯净的原版游戏进度，无修改器、模组或作弊。
ludocard-tag-desc-modded = 使用可能改变游戏玩法的模组（Mods）获得的进度。
ludocard-tag-desc-bossprep = 存档位置策略性地放在游戏重要 Boss 之前。
ludocard-tag-desc-starter = 游戏初期的存档，累积了资源或跳过了新手教学。
ludocard-tag-desc-cleanstart = 角色创建或介绍过场之后的存档，直接开始真实的游戏进程。
ludocard-tag-desc-midgame = 存档位于主线任务中途（非常适合丢失存档的玩家）。
ludocard-tag-desc-postgame = 战役已完成，适合探索隐藏 Boss、未完成的成就或支线活动。
ludocard-tag-desc-opbuild = 针对装备、等级和 Build 极强的角色的存档（Overpowered）。
ludocard-tag-desc-unlimitedcash = 拥有上限或无限资金、金币或升级资源的存档。
ludocard-tag-desc-allcollectibles = 解锁了所有繁琐的收集品和次要成就的存档。
ludocard-tag-desc-hardcore = 极限难度或开启永久死亡的存档（极限生存）。
ludocard-tag-desc-speedrunready = 适合练习速通分段或放在最快路线上的存档。
ludocard-tag-desc-legit = 纯净获得的进度，无作弊、作弊码或利用 bug（Glitches）。
ludocard-preset-tag-desc-perf = 专注于提升 FPS 和流畅度的优化。
ludocard-preset-tag-desc-quality = 专注于最高画质表现的优化。
ludocard-preset-tag-desc-balanced = 画面保真度与 FPS 帧率之间的理想平衡。
ludocard-preset-tag-desc-deck = 专为 Steam Deck/掌机屏幕和电池优化的预设。
ludocard-preset-tag-desc-potato = 适合在非常老的电脑和低端笔记本上运行。
ludocard-preset-tag-desc-controls = 自定义控制器、手柄映射或快捷键绑定。
ludocard-preset-tag-desc-rt = 开启光线追踪的细致优化，旨在保持良好的帧率。
ludocard-preset-tag-desc-4k = 专注于 4K 高清电视和显示器的优化。
ludocard-preset-tag-desc-vr = 针对虚拟现实（VR）中理想 FPS 进行优化的设置。

ludocard-schedule-auto-routine = 自动备份计划
ludocard-schedule-auto-routine-desc = 设置何时自动进行备份。
ludocard-schedule-by-interval = 按时间间隔
ludocard-schedule-by-days = 按星期几
ludocard-schedule-backup-every = 备份间隔
ludocard-schedule-1-hour = 1 小时
ludocard-schedule-3-hours = 3 小时
ludocard-schedule-6-hours = 6 小时
ludocard-schedule-12-hours = 12 小时
ludocard-schedule-24-hours = 24 小时
ludocard-schedule-at-time = 在指定时间
ludocard-schedule-games-in-schedule = 计划中的游戏
ludocard-schedule-games-in-schedule-desc = 选择哪些游戏遵循此自动备份计划。
ludocard-schedule-btn-save = 保存计划
ludocard-schedule-saved-toast = 计划保存成功

ludocard-day-sun = 日
ludocard-day-mon = 一
ludocard-day-tue = 二
ludocard-day-wed = 三
ludocard-day-thu = 四
ludocard-day-fri = 五
ludocard-day-sat = 六

ludocard-notification-alerts = 提醒与通知
ludocard-notification-alerts-desc = 选择您希望如何接收备份的提醒。
ludocard-notification-windows = Windows 系统通知
ludocard-notification-windows-desc = 备份成功完成时发出通知。
ludocard-notification-toast-enabled = 通知已开启
ludocard-notification-toast-disabled = 通知已关闭
ludocard-notification-fail-alerts = 失败报警
ludocard-notification-fail-alerts-desc = 备份失败时立即通知。
ludocard-notification-toast-fail-enabled = 失败通知已开启
ludocard-notification-toast-fail-disabled = 失败通知已关闭
ludocard-notification-sounds = 报警音效
ludocard-notification-sounds-desc = 在备份完成或失败时播放音效。
ludocard-notification-toast-sounds-enabled = 音效已开启
ludocard-notification-toast-sounds-disabled = 音效已关闭


