# pre-commit-hook
Даний проект дає змогу автоматично запускати перевірку перед комітом у git на наявність відкритих паролів в проекті 
1. Клонуємо проект який потрібно просканувати на відкриті значення паролів і переходимо в нього
```sh
[vitalik@fedora ~]$ git clone git@github.com:vshpelyk/kbot.git
Cloning into 'kbot'...
The authenticity of host 'github.com (140.82.121.3)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? y
Please type 'yes', 'no' or the fingerprint: yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
remote: Enumerating objects: 169, done.
remote: Counting objects: 100% (31/31), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 169 (delta 11), reused 22 (delta 7), pack-reused 138
Receiving objects: 100% (169/169), 24.67 MiB | 9.31 MiB/s, done.
Resolving deltas: 100% (67/67), done.
[vitalik@fedora ~]$ cd kbot/
```
2. Встановлюємо gitleaks та pre-commit. 
На цьому кроці ми встановимо gitleaks (в системі повиннен бути встановлений go), та скопіюємо pre-commit в папку .git/hooks нашого поточного проекту
```sh
    curl -o install_gitleaks.sh https://raw.githubusercontent.com/vshpelyk/pre-commit-hook/main/install_gitleaks.sh && chmod +x install_gitleaks.sh && ./install_gitleaks.sh

    talik@fedora kbot]$ curl -o install_gitleaks.sh https://raw.githubusercontent.com/vshpelyk/pre-commit-hook/main/install_gitleaks.sh && chmod +x install_gitleaks.sh && ./install_gitleaks.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1405  100  1405    0     0   5037      0 --:--:-- --:--:-- --:--:--  5035
Встановлення gitleaks...
Cloning into 'gitleaks'...
remote: Enumerating objects: 8499, done.
remote: Counting objects: 100% (1482/1482), done.
remote: Compressing objects: 100% (467/467), done.
remote: Total 8499 (delta 1254), reused 1106 (delta 1015), pack-reused 7017
Receiving objects: 100% (8499/8499), 5.25 MiB | 9.72 MiB/s, done.
Resolving deltas: 100% (4665/4665), done.
go: downloading github.com/rs/zerolog v1.26.1
go: downloading github.com/spf13/cobra v1.2.1
go: downloading github.com/spf13/viper v1.8.1
go: downloading github.com/fsnotify/fsnotify v1.4.9
go: downloading github.com/hashicorp/hcl v1.0.0
go: downloading github.com/magiconair/properties v1.8.5
go: downloading github.com/mitchellh/mapstructure v1.4.1
go: downloading github.com/pelletier/go-toml v1.9.3
go: downloading github.com/spf13/afero v1.6.0
go: downloading github.com/spf13/cast v1.3[vi.1
go: downloading github.com/spf13/jwalterweatherman v1.1.0
go: downloading github.com/spf13/pflag v1.0.5
go: downloading github.com/subosito/gotenv v1.2.0
go: downloading gopkg.in/ini.v1 v1.62.0
go: downloading gopkg.in/yaml.v2 v2.4.0
go: downloading github.com/BobuSumisu/aho-corasick v1.0.3
go: downloading github.com/charmbracelet/lipgloss v0.5.0
go: downloading github.com/fatih/semgroup v1.2.0
go: downloading github.com/gitleaks/go-gitdiff v0.9.0
go: downloading github.com/h2non/filetype v1.1.3
go: downloading golang.org/x/sys v0.6.0
go: downloading golang.org/x/text v0.3.8
go: downloading github.com/lucasb-eyer/go-colorful v1.2.0
go: downloading github.com/mattn/go-runewidth v0.0.14
go: downloading github.com/muesli/reflow v0.2.1-0.20210115123740-9e1d0d53df68
go: downloading golang.org/x/sync v0.0.0-20210220032951-036812b2e83c
go: downloading github.com/muesli/termenv v0.15.1
go: downloading github.com/rivo/uniseg v0.2.0
go: downloading github.com/aymanbagabas/go-osc52/v2 v2.0.1
go: downloading github.com/mattn/go-isatty v0.0.17
[sudo] password for vitalik: 
gitleaks успішно встановлено.
Копіювання pre-commit hook і надання прав на виконання...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  1288  100  1288    0     0   4966      0 --:--:-- --:--:-- --:--:--  4972
pre-commit hook успішно скопійовано і налаштовано.

```
2. Щоб увімкнути перевірку gitleaks, виконайте команду:
    git config hooks.gitleaks.enable true

    [vitalik@fedora kbot]$ git commit -m "Test password in project"
Запуск gitleaks...

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

4:36PM INF scan completed in 2.86ms
4:36PM WRN leaks found: 1
gitleaks виявив секрети у вашому коді. Коміт відхилено.

```SH
3. 