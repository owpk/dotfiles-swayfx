#!/bin/bash

# Скрипт для переключения окон в Wayland/GNOME с использованием расширения Windows
# Использование: ./window-switcher.sh <wm_class> <program_name> [program_args...]
# Refer: https://github.com/ickyicky/window-calls

if [ $# -lt 2 ]; then
    echo "Usage: $0 <wm_class> <program_name> [program_args...]"
    echo "Example: $0 org.gnome.Nautilus nautilus"
    echo "Example: $0 Code code --new-window"
    exit 1
fi

WM_CLASS="$1"
PROGRAM_NAME="$2"
shift 2
PROGRAM_ARGS="$@"

# Функция для очистки ответа gdbus (удаляем скобки и кавычки)
clean_gdbus_response() {
    echo "$1" | sed "s/^('//;s/',)$//;s/''//g"
}

# Функция для получения списка окон в текущем workspace
get_windows() {
    local response=$(gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.List \
        2>/dev/null)
    
    local cleaned=$(clean_gdbus_response "$response")
    echo "$cleaned" | jq -c ".[] | select(.wm_class == \"$WM_CLASS\" and .in_current_workspace == true)" 2>/dev/null
}

# Функция для активации окна по ID
activate_window() {
    local window_id="$1"
    gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.Activate "$window_id" \
        >/dev/null 2>&1
}

# Функция для запуска программы
launch_program() {
    echo "Запускаем $PROGRAM_NAME $PROGRAM_ARGS..."
    nohup "$PROGRAM_NAME" $PROGRAM_ARGS >/dev/null 2>&1 &
}

# Функция для получения ID всех окон с указанным wm_class
get_window_ids() {
    get_windows | jq -r '.id' 2>/dev/null
}

# Функция для получения количества окон
get_window_count() {
    get_windows | jq -s 'length' 2>/dev/null
}

# Функция для получения текущего активного окна
get_active_window_id() {
    local response=$(gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.List \
        2>/dev/null)
    
    local cleaned=$(clean_gdbus_response "$response")
    echo "$cleaned" | jq -c ".[] | select(.focus == true) | .id" 2>/dev/null | head -1
}

# Функция для получения всех окон (для отладки)
get_all_windows() {
    local response=$(gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.List \
        2>/dev/null)
    
    clean_gdbus_response "$response"
}

# Основная логика
main() {
    # Получаем список окон
    windows=$(get_windows)
    
    if [ -z "$windows" ] || [ "$windows" = "null" ]; then
        # Окон не найдено - запускаем программу
        echo "Окно не найдено, запускаем $PROGRAM_NAME"
        launch_program
    else
        # Получаем количество окон и их ID
        window_count=$(echo "$windows" | jq -s 'length' 2>/dev/null)
        window_ids=$(echo "$windows" | jq -r '.id' 2>/dev/null)
        
        if [ "$window_count" -eq 1 ]; then
            # Одно окно - активируем его
            window_id=$(echo "$window_ids" | head -1)
            echo "Активируем окно ID: $window_id"
            activate_window "$window_id"
        else
            # Несколько окон - переключаемся между ними
            current_active=$(get_active_window_id)
            
            # Преобразуем ID окон в массив
            IFS=$'\n' read -d '' -ra window_array <<< "$window_ids"
            
            # Находим индекс текущего активного окна
            current_index=-1
            for i in "${!window_array[@]}"; do
                if [ "${window_array[$i]}" = "$current_active" ]; then
                    current_index=$i
                    break
                fi
            done
            
            # Выбираем следующее окно для активации
            if [ "$current_index" -eq -1 ] || [ "$((current_index + 1))" -ge "${#window_array[@]}" ]; then
                # Если текущее окно не найдено или это последнее окно - берем первое
                next_window_id="${window_array[0]}"
                echo "Активируем первое окно ID: $next_window_id"
            else
                # Берем следующее окно
                next_window_id="${window_array[$((current_index + 1))]}"
                echo "Активируем следующее окно ID: $next_window_id"
            fi
            
            activate_window "$next_window_id"
        fi
    fi
}

# Проверяем зависимости
if ! command -v jq >/dev/null 2>&1; then
    echo "Ошибка: jq не установлен. Установите: sudo apt install jq"
    exit 1
fi

# Проверяем доступность расширения
if ! gdbus introspect --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows >/dev/null 2>&1; then
    echo "Ошибка: Расширение Windows не установлено или не активировано"
    echo "Установите расширение: https://extensions.gnome.org/extension/4699/windows/"
    exit 1
fi

# Запускаем основную логику
main
