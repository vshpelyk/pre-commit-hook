#!/bin/bash

# Перевірка чи gitleaks вже встановлено
if command -v gitleaks &> /dev/null
then
    echo "gitleaks вже встановлено."
else
    # Встановлення gitleaks
    echo "Встановлення gitleaks..."

    # Перевірка наявності Go
    if ! command -v go &> /dev/null
    then
        echo "Go не встановлено. Встановіть Go перед продовженням."
        exit 1
    fi

    # Завантаження та встановлення gitleaks з вихідного коду
    temp_dir=$(mktemp -d)
    cd $temp_dir

    # Клонування репозиторію
    git clone https://github.com/gitleaks/gitleaks.git
    cd gitleaks

    # Компіляція та встановлення
    go build -o gitleaks
    sudo mv gitleaks /usr/local/bin/

    # Очищення
    cd ..
    rm -rf $temp_dir

    echo "gitleaks успішно встановлено."
fi

# Копіювання pre-commit hook і надання прав на виконання
echo "Копіювання pre-commit hook і надання прав на виконання..."
curl -o .git/hooks/pre-commit https://raw.githubusercontent.com/vshpelyk/pre-commit-hook/main/pre-commit
chmod +x .git/hooks/pre-commit

echo "pre-commit hook успішно скопійовано і налаштовано."
